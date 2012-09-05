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


@interface VexDrawBinaryReader()
{    
    const unsigned char *rawData;
	unsigned int index;
	unsigned int bit;
	unsigned int dataLen;
    
	unsigned int fillIndexNBits;
	unsigned int strokeIndexNBits;	
}
@end

@implementation VexDrawBinaryReader


int const TWIPS = 32;

static const unsigned int maskArray[] = 
{
    0x00, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x7F, 0xFF,
    0x01FF, 0x03FF, 0x07FF, 0x0FFF, 0x1FFF, 0x3FFF, 0x7FFF, 0xFFFF,
    0x01FFFF, 0x03FFFF, 0x07FFFF, 0x0FFFFF, 0x1FFFFF, 0x3FFFFF, 0x7FFFFF, 0xFFFFFF,
    0x01FFFFFF, 0x03FFFFFF, 0x07FFFFFF, 0x0FFFFFFF, 0x1FFFFFFF, 0x3FFFFFFF, 0x7FFFFFFF, 0xFFFFFFFF
};

CGColorSpaceRef colorSpace;

-(VexDrawBinaryReader*) initWithData:(NSData *) theData usingVexObject:(VexObject *) vo
{
    self = [super init];
    if(self)
    {
        rawData = theData.bytes;
        dataLen = theData.length;
        [self parseTags:vo];
        
    }
    return self;
}

-(void) parseTags:(VexObject *) vo
{
    index = 0;
    bit = 8;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    while (index < dataLen)
    {
        VexDrawTag tag = [self readByte];
        
        switch(tag)
        {
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
                [self parseSymbol:vo];
                 //Symbol *symbol = [self parseSymbol:vo];
                //[[vo definitions] addObject:symbol];
                break;
                
            case TimelineDefinition:
                //var tl:Timeline = parseTimeline(vo);
                //vo.definitions.set(tl.id, tl);
                break;

                
            case End:		
                break;					
        }
        
    }
    
    CGColorSpaceRelease(colorSpace);
}

-(Symbol *) parseSymbol:(VexObject *) vo
{
    Symbol *result = [[Symbol alloc] init];
    
    return result;
}

-(void) parseGradientFills:(VexObject *) vo
{
    [self readNBitValue]; // padding
    int gradientCount = [self readNBits:11];
    
    for (int gc = 0; gc < gradientCount; gc++)
    {
        // type:i byte, stopColors[...]<Int>, stopRatios[...]<Int>, matrix[6]<Int>
        
        GradientType type = [self readNBits:3];
        
        int lineNBits = [self readNBitValue];
        float tlX = [self readNBitInt:lineNBits] / TWIPS;
        float tlY = [self readNBitInt:lineNBits] / TWIPS;
        float trX = [self readNBitInt:lineNBits] / TWIPS;
        float trY = [self readNBitInt:lineNBits] / TWIPS;
        
        GradientLine line = {tlX, tlY, trX, trY};
        
        GradientFill *gradient = [[GradientFill alloc] initWithGradientType:type gradientLine:line];
        //var gradient:CanvasGradient = g.createLinearGradient(tlX, tlY,trX, trY);
        
        // stop colors
        int colorNBits = [self readNBitValue];
        int ratioNBits = [self readNBitValue];
        int count = [self readNBits:11];        
        for (int stops = 0; stops < count; stops++)
        {
            CGColorRef col = [self readAndCreateColor:colorNBits];
            float ratio = [self readNBits:ratioNBits] / 255;            
            GradientStop *stop = [[GradientStop alloc] initWithColor:col ratio: ratio];
            
            [[gradient stops] addObject:stop];
        }	
        
        [[vo fills] addObject:gradient];
        NSLog(@"grad: %@", gradient);
    }
    
    [self flushBits];
}

-(void) parseSolidFills:(VexObject *) vo
{
    fillIndexNBits = [self readNBits:8];
    int nBits = [self readNBitValue];
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
    int colorNBits = [self readNBitValue];
    int lineWidthNBits = [self readNBitValue];
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

-(int) readNBitValue
{
    int result = [self readNBits:5];
    result = (result == 0) ? 0 : result + 2;
    return result;
}

-(CGRect) readNBitRect
{
    int nBits = [self readNBitValue];
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
        r / 255.0,        
        g / 255.0,
        b / 255.0,
        a / 255.0,
    };
    CGColorRef c = CGColorRetain(CGColorCreate(colorSpace, components));
    return c;
}




@end








