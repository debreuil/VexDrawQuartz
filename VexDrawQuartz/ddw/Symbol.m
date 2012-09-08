//
//  Symbol.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "Symbol.h"
#import "Shape.h"
#import "Stroke.h"
#import "Fill.h"
#import "SolidFill.h"
#import "GradientFill.h"

@interface Symbol()
//@property (nonatomic, weak) CGImageRef *image;
@end

@implementation Symbol

//@synthesize image = _image;

@synthesize vo = _vo;
@synthesize shapes = _shapes;

-(id) init
{
    self = [super init];
    if(self)
    {
        self.isTimeline = false;
        _shapes = [[NSMutableArray alloc] init];
    }
    return self;    
}

+(void) drawSymbol:(Symbol *)symbol atScaleX:(float)scaleX yScale:(float)scaleY withContext: (CGContextRef)context
{
    CGRect bnds = symbol.bounds;
    float offsetX = -bnds.origin.x * scaleX;
    float offsetY = -bnds.origin.y * scaleY;
    
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, offsetX, offsetY);
    if(scaleX != 1.0 || scaleY != 1.0)
    {
        CGContextScaleCTM(context, scaleX, scaleY);
    }
    
    VexObject *vo = symbol.vo;
    for (Shape *shape in symbol.shapes)
    {
        
        if(shape.fillIndex > 0)
        {
            Fill *fill = [vo.fills objectAtIndex:shape.fillIndex];
            if([fill isKindOfClass:[SolidFill class]])
            {
                CGContextSetFillColorWithColor(context, ((SolidFill *)fill).color);
                CGContextAddPath(context, shape.path);
                CGContextFillPath(context);
            }
            else if([fill isKindOfClass:[GradientFill class]])
            {
                CGContextSaveGState(context);
                GradientFill *gf = (GradientFill *)fill;
                CGContextAddPath(context, shape.path);
                CGContextClip(context);
                CGContextDrawLinearGradient(context, gf.gradient, gf.startPoint, gf.endPoint, 0);
                CGContextRestoreGState(context);
            }
        }
        
        if(shape.strokeIndex > 0)
        {
            Stroke *stroke = [vo.strokes objectAtIndex:shape.strokeIndex];
            CGContextSetLineWidth(context, stroke.lineWidth);
            CGContextSetStrokeColorWithColor(context, stroke.color);
            CGContextAddPath(context, shape.path);
            CGContextStrokePath(context);
        }        
    }
    CGContextRestoreGState(context);
}

- (CGImageRef)createCGImageAtScaleX:(float)scaleX scaleY:(float)scaleY
{
    CGSize screenSize = CGSizeMake(self.bounds.size.width * scaleX, self.bounds.size.height * scaleY);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(   nil,
                                                 screenSize.width,
                                                 screenSize.height,
                                                 8,
                                                 4*(int)screenSize.width,
                                                 colorSpaceRef,
                                                 kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, 0.0, screenSize.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    [Symbol drawSymbol:self atScaleX:scaleX yScale:scaleY withContext:context];
    
    CGImageRef cgImageRef = CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(context);
    
    
    return cgImageRef;
}

@end
