//
//  GradientFill.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "GradientFill.h"
#import "GradientStop.h"
#import "Fill.h"

@implementation GradientFill

@synthesize stops = _stops;
@synthesize type = _type;
@synthesize startPoint = _startPoint;
@synthesize endPoint = _endPoint;
@synthesize gradient = _gradient;

-(id) init
{
    self = [super init];
    if(self)
    {
        _stops = [[NSMutableArray alloc] init];
    }
    return self;    
}

-(id) initWithGradientType:(GradientType) type startPoint:(CGPoint) startPoint endPoint:(CGPoint) endPoint
{
    self = [self init];
    if(self)
    {
        _type = type;
        _startPoint = startPoint;
        _endPoint = endPoint;
    }
    return self;
}

-(void) createGradient
{
    if(self.stops != nil && self.stops.count > 0)
    {
        CGFloat components[4 * self.stops.count];
        CGFloat locations[self.stops.count];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        for (int i = 0; i < self.stops.count; i++)
        {
            GradientStop *stop = (GradientStop *)[self.stops objectAtIndex:i];
            
            const CGFloat *comps = CGColorGetComponents(stop.color);
            components[4 * i + 0] = comps[0];
            components[4 * i + 1] = comps[1];
            components[4 * i + 2] = comps[2];
            components[4 * i + 3] = comps[3];
            
            locations[i] = stop.ratio;            
        }        
        _gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);
        CGColorSpaceRelease(colorSpace);
    }
}

-(CGGradientRef) gradient
{
    if(_gradient == nil)
    {
        [self createGradient];
    }
    return _gradient;
}    
    
@end
