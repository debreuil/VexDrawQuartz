//
//  GradientStop.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-04.
//
//

#import "GradientStop.h"

@implementation GradientStop

@synthesize color = _color;
@synthesize ratio = _ratio;

-(id) initWithColor:(CGColorRef) color ratio:(float) ratio
{
    self = [super init];
    if(self)
    {
        _color = color;
        _ratio = ratio;
    }
    return self;
}

@end
