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

@implementation Symbol

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

+(void) drawSymbol:(Symbol *)symbol withMetricsFrom:(Instance *)metrics withContext: (CGContextRef)context
{
    CGRect bnds = symbol.bounds;
    float offsetX = -bnds.origin.x * metrics.scaleX;
    float offsetY = -bnds.origin.y * metrics.scaleY;
    
    //var cv:HTMLCanvasElement = vo.createCanvas(metrics.name, cast (bnds.width * metrics.scaleX), cast (bnds.height * metrics.scaleY));
    //var g:CanvasRenderingContext2D = cv.getContext("2d");
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, offsetX, offsetY);
    if(metrics.hasScale)
    {
        CGContextScaleCTM(context, metrics.scaleX, metrics.scaleY);
    }
    
    //CGContextTranslateCTM(context, 322, 222);
    //CGContextScaleCTM(context, 4.0, 4.0);
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

@end
