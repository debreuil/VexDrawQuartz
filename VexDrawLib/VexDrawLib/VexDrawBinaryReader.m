//
//  VexDrawBinaryReader.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-03.
//
//

#import "VexDrawBinaryReader.h"
#import "VexObject.h"
#import "VexDrawTag.h"
#import "Stroke.h"
#import "SolidFill.h"
#import "GradientFill.h"
#import "GradientStop.h"
#import "Symbol.h"
#import "Shape.h"
#import "Timeline.h"
#import "Instance.h"
#import "Path.h"
#import "Image.h"


@interface VexDrawBinaryReader()
{    
    const unsigned char *rawData;
	unsigned int index;
	unsigned int bit;
	unsigned int dataLen;
    
	unsigned int fillIndexNBits;
	unsigned int strokeIndexNBits;	
}

-(Symbol *) parseSymbol:(VexObject *) vo;
-(void) flushBits;
-(unsigned int) readByte;
-(BOOL) readBit;
-(int) readNBitCount;
-(CGRect) readNBitRect;
-(int) readNBitInt:(int)nBits;
-(int) readNBits:(int) nBits;
-(int) readNBits:(int) nBits startValue:(int) result;
-(CGColorRef) readAndCreateColor:(int) nBits;
@end



@implementation VexDrawBinaryReader    

float const TWIPS = 32;
int const idBitCount = 16;

static const unsigned int maskArray[] =
{
    0x00, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x7F, 0xFF,
    0x01FF, 0x03FF, 0x07FF, 0x0FFF, 0x1FFF, 0x3FFF, 0x7FFF, 0xFFFF,
    0x01FFFF, 0x03FFFF, 0x07FFFF, 0x0FFFFF, 0x1FFFFF, 0x3FFFFF, 0x7FFFFF, 0xFFFFFF,
    0x01FFFFFF, 0x03FFFFFF, 0x07FFFFFF, 0x0FFFFFFF, 0x1FFFFFFF, 0x3FFFFFFF, 0x7FFFFFFF, 0xFFFFFFFF
};

CGColorSpaceRef colorSpace;

-(VexObject *) createVexObjectFromData:(NSData *) data
{
    VexObject *result = [[VexObject alloc] init];
    
    rawData = (const unsigned char *)data.bytes;
    dataLen = data.length;
    [self parseTags:result];
    
    return result;
}

-(void) parseTags:(VexObject *) vo
{
    index = 0;
    bit = 8;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    while (index < dataLen)
    {
        VexDrawTag tag = [self readByte];
        int len = [self readNBitInt:24];
        int startLoc = index;
        
        switch(tag)
        {
            case DefinitionNameTable:
                [self parseNameTable:vo.definitionNameTable];
                break;
                
            case InstanceNameTable:
                [self parseNameTable:vo.instanceNameTable];
                break;
                
            case PathNameTable:
                [self parseStringTable:vo.pathTable];
                break;
                
            case StrokeList:
                [self parseStrokes:vo];
                break;
                
            case SolidFillList:
                [self parseSolidFills:vo];
                break;
                                
            case GradientFillList:
                [self parseGradientFills:vo];
                break;
                
            case SymbolDefinition:
            {
                Symbol *symbol = [self parseSymbol:vo];
                [[vo definitions] setObject:symbol forKey:symbol.definitionId];
                break;
            }
                
            case ImageDefinition:
            {
                Image *img = [self parseImage:vo];
                [[vo definitions] setObject:img forKey:img.definitionId];
                break;
            }
                
            case TimelineDefinition:
            {
                Timeline *tl = [self parseTimeline:vo];
                [[vo definitions] setObject:tl forKey:tl.definitionId];
                break;
            }
                
            case End:		
                break;
				
            default:
                index += len; // skip tag
                break;
        }
        
        if (index - startLoc != len)
        {
            NSLog(@"Parse error. tagStart:%d tagEnd:%d len:%d tagType:%d ", startLoc, index, len, tag);
            index = startLoc + len;
        }
        
    }
    
    CGColorSpaceRelease(colorSpace);
}

-(void) parseNameTable:(NSMutableDictionary *)table
{
    int nameNBits = [self readNBitCount];
    int stringCount = [self readNBits:16];
    
    for (int i = 0; i < stringCount; i++)
    {
        NSNumber *idNum = [NSNumber numberWithInt:[self readNBitInt:idBitCount]];
        int charCount = [self readNBits:16];
        NSMutableString *s = [[NSMutableString alloc] initWithString:@""];
        
        for (int j = 0; j < charCount; j++)
        {
            int charVal = [self readNBits:nameNBits];
            [s appendString:[NSString stringWithFormat: @"%C", (unichar)charVal]];
        }
        
        [table setObject:s forKey:idNum];
    }
    
    [self flushBits];
}

-(void) parseStringTable:(NSMutableArray *)table
{
    int nameNBits = [self readNBitCount];
    int stringCount = [self readNBits:16];
    
    for (int i = 0; i < stringCount; i++)
    {
        int charCount = [self readNBits:16];
        NSMutableString *s = [[NSMutableString alloc] initWithString:@""];
        
        for (int j = 0; j < charCount; j++)
        {
            int charVal = [self readNBits:nameNBits];
            [s appendString:[NSString stringWithFormat: @"%C", (unichar)charVal]];
        }
        
        [table addObject:s];
    }
    
    [self flushBits];
}

-(Timeline *) parseTimeline:(VexObject *) vo
{
    Timeline *result = [[Timeline alloc] init];
    result.vo = vo;
    
    result.definitionId = [NSNumber numberWithInt:[self readNBits:idBitCount]];
    result.bounds = [self readNBitRect];
    
    int instancesCount = [self readNBits:11];
    for (int i = 0; i < instancesCount; i++)
    {
        // defid32,hasVals[7:bool], x?,y?,scaleX?, scaleY?, rotation?, shear?, "name"?
        NSNumber *defId = [NSNumber numberWithInt:[self readNBits:idBitCount]];
        int instId = [self readNBits:idBitCount];
        
        Instance *inst = [[Instance alloc] initWithId:instId];
        inst.vo = vo;
        inst.definitionId = defId;
        
        BOOL hasX = [self readBit];
        BOOL hasY = [self readBit];
        BOOL hasScaleX = [self readBit];
        BOOL hasScaleY = [self readBit];
        BOOL hasRotation = [self readBit];
        BOOL hasShear = [self readBit];
        BOOL hasName = [self readBit];
        
        if (hasX || hasY || hasScaleX || hasScaleY || hasRotation || hasShear)
        {
            int mxNBits = [self readNBitCount];
            if (hasX)
            {
                inst.x = [self readNBitInt:mxNBits] / TWIPS;
            }
            if (hasY)
            {
                inst.y = [self readNBitInt:mxNBits] / TWIPS;
            }
            if (hasScaleX)
            {
                inst.scaleX = [self readNBitInt:mxNBits] / TWIPS;
                inst.hasScale = true;
            }
            if (hasScaleY)
            {
                inst.scaleY = [self readNBitInt:mxNBits] / TWIPS;
                inst.hasScale = true;
            }
            if (hasRotation)
            {
                inst.rotation = [self readNBitInt:mxNBits] / TWIPS;
                inst.hasRotation = true;
            }
            if (hasShear)
            {
                inst.shear = [self readNBitInt:mxNBits] / TWIPS;
                inst.hasShear = true;
            }
        }
        
        if (hasName)
        {
            // todo: read name
        }
        
        [result.instances addObject:inst];
    }
    
    [self flushBits];
    
    return result;
}

-(Symbol *) parseSymbol:(VexObject *) vo
{
    Symbol *result = [[Symbol alloc] init];
    result.vo = vo;
    
    result.definitionId = [NSNumber numberWithInt:[self readNBits:idBitCount]];
        
    result.bounds = [self readNBitRect];
    
    // parse paths
    int pathsCount = [self readNBits:11];
    int pathIndexNBits = [self readNBitCount];
    
    for (int i = 0; i < pathsCount; i++)
    {
        CGMutablePathRef segments = CGPathCreateMutable();
        
        int nBits = [self readNBitCount];
        int segmentCount = [self readNBits:11];
        for (int i = 0; i < segmentCount; i++)
        {
            int segType = [self readNBits:2];
            CGPoint pt = {[self readNBitInt:nBits] / TWIPS, [self readNBitInt:nBits] / TWIPS};
            
            switch(segType)
            {
                case 0:
                {
                    CGPathMoveToPoint(segments, nil, pt.x, pt.y);
                    break;
                }
                case 1:
                {
                    CGPathAddLineToPoint(segments, nil, pt.x, pt.y);
                    break;
                }
                case 2:
                {
                    CGPathAddQuadCurveToPoint(segments, nil, pt.x, pt.y,
                                              [self readNBitInt:nBits] / TWIPS,
                                              [self readNBitInt:nBits] / TWIPS);
                    break;
                }
                case 3:
                {
                    CGPathAddCurveToPoint(segments, nil, pt.x, pt.y,
                                          [self readNBitInt:nBits] / TWIPS,
                                          [self readNBitInt:nBits] / TWIPS,
                                          [self readNBitInt:nBits] / TWIPS,
                                          [self readNBitInt:nBits] / TWIPS);
                    break;
                }
                    
            }
        }
        Path *path = [[Path alloc] initWithSegments:segments];
        [result.paths addObject:path];
    }
    
    
    // parse shapes. [stroke, color, path]
    int shapesCount = [self readNBits:11];
    for (int i = 0; i < shapesCount; i++)
    {
        int strokeIndex = [self readNBits:strokeIndexNBits];
        int fillIndex = [self readNBits:fillIndexNBits];
        int pathIndex = [self readNBits:pathIndexNBits];

        Shape *shape = [[Shape alloc] initWithStrokeIndex:strokeIndex fillIndex:fillIndex pathIndex:pathIndex];
        [result.shapes addObject:shape];
    }
    
    [self flushBits];
    
    return result;
}

-(Image *) parseImage:(VexObject *) vo
{
    
    NSNumber *defId = [NSNumber numberWithInt:[self readNBits:idBitCount]];
    
    CGRect bnds = [self readNBitRect];
    
    int pathId = [self readNBits:11];    
    NSString *path = [vo.pathTable objectAtIndex:pathId];
    
    Image *result = [[Image alloc] initWithPath:path];
    result.vo = vo;
    result.definitionId = defId;
    result.bounds = bnds;
    
    [self flushBits];
    
    return result;
    
}
-(void) parseGradientFills:(VexObject *) vo
{
    [self readNBits:5]; // padding
    int gradientCount = [self readNBits:11];
    
    for (int gc = 0; gc < gradientCount; gc++)
    {
        // type:i byte, stopColors[...]<Int>, stopRatios[...]<Int>, matrix[6]<Int>
        
        GradientType type = [self readNBits:3];
        
        int lineNBits = [self readNBitCount];
        CGPoint startPoint = CGPointMake([self readNBitInt:lineNBits] / TWIPS, [self readNBitInt:lineNBits] / TWIPS);
        CGPoint endPoint = CGPointMake([self readNBitInt:lineNBits] / TWIPS, [self readNBitInt:lineNBits] / TWIPS);
        GradientFill *gradient = [[GradientFill alloc] initWithGradientType:type startPoint:startPoint endPoint:endPoint];
       
        // stop colors
        int colorNBits = [self readNBitCount];
        int ratioNBits = [self readNBitCount];
        int count = [self readNBits:11];        
        for (int stops = 0; stops < count; stops++)
        {
            CGColorRef col = [self readAndCreateColor:colorNBits];
            float ratio = [self readNBits:ratioNBits] / 255.0;
            GradientStop *stop = [[GradientStop alloc] initWithColor:col ratio: ratio];
            
            [[gradient stops] addObject:stop];
        }	
        
        [vo.fills addObject:gradient];
    }
    
    [self flushBits];
}

-(void) parseSolidFills:(VexObject *) vo
{
    fillIndexNBits = [self readNBits:8];
    int nBits = [self readNBitCount];
    int count = [self readNBits:11];
    for (int i = 0; i < count; i++)
    {
        CGColorRef col = [self readAndCreateColor:nBits];
        SolidFill *fill = [[SolidFill alloc] initWithColor:col];

        [[vo fills] addObject:fill];
    }
    [self flushBits];
}

-(void) parseStrokes:(VexObject *) vo
{    
    strokeIndexNBits = [self readNBits:8];
    // stroke colors
    int colorNBits = [self readNBitCount];
    int lineWidthNBits = [self readNBitCount];
    int count = [self readNBits:11];
    for (int i = 0; i < count; i++)
    {
        CGColorRef col = [self readAndCreateColor:colorNBits];
        float lw = [self readNBits:lineWidthNBits] / TWIPS;
        Stroke *stroke = [[Stroke alloc] initWithColor:col lineWidth:lw];

        [[vo strokes] addObject:stroke];
    }		
    
    [self flushBits];
}

#pragma binary reader

-(void) flushBits
{
    if (bit != 8)
    {
        bit = 8;
        index++;
    }
    
    if ((index % 4) != 0)
    {
        index += 4 - (index % 4);
    }
}

-(unsigned int) readByte
{    
    return (unsigned int)rawData[index++];
}

-(BOOL) readBit
{
    return [self readNBits:1] == 1 ? YES : NO;
}

-(int) readNBitCount
{
    int result = [self readNBits:5];
    return result + 2;
}

-(CGRect) readNBitRect
{
    int nBits = [self readNBitCount];
    CGRect result = {[self readNBitInt:nBits] / TWIPS,
                    [self readNBitInt:nBits] / TWIPS,
                    [self readNBitInt:nBits] / TWIPS,
                    [self readNBitInt:nBits] / TWIPS};
    return result;
}

-(int) readNBitInt:(int)nBits
{
    int result;
    int bitMask = pow(2, bit - 1);
    if ((rawData[index] & bitMask) != 0)
    {
        result = [self readNBits:nBits startValue: -1];
    }
    else
    {
        result = [self readNBits:nBits];
    }	
    return result;
}

-(int) readNBits:(int) nBits
{
    return [self readNBits:nBits startValue:0];
}

-(int) readNBits:(int) nBits startValue:(int) result
{
    int addingVal;
    int dif;
    int mask;
    
    while (nBits > 0)
    {
        if (bit > nBits)
        {
            dif = bit - nBits;
            mask = maskArray[nBits] << dif;
            addingVal = (rawData[index] & mask) >> dif;
            result = (result << nBits) + addingVal;
            bit -= nBits;
            nBits = 0;
        }
        else
        {
            mask = maskArray[bit];
            addingVal = (rawData[index++] & mask);
            result = (result << bit) + addingVal;
            nBits -= bit;	
            bit = 8;
        }
    }
    return result;
}

-(CGColorRef) readAndCreateColor:(int) nBits
{
    unsigned int afrgb = [self readNBits:nBits];
    unsigned int a = 0xFF - ((afrgb & 0xFF000000) >> 24);
    unsigned int r = (afrgb & 0xFF0000) >> 16;
    unsigned int g = (afrgb & 0xFF00) >> 8;
    unsigned int b = (afrgb & 0xFF);
    CGFloat components[4] =
    {
        r / 255.0f,
        g / 255.0f,
        b / 255.0f,
        a / 255.0f,
    };
    CGColorRef c = CGColorRetain(CGColorCreate(colorSpace, components));
    return c;
}




@end








