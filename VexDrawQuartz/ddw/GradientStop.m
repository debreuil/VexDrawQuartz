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

-(id) initWithColor:(CGColorRef) theColor ratio:(float) theRatio
{
    self = [super init];
    if(self)
    {
        _color = theColor;
        _ratio = theRatio;
    }
    return self;
}

@end
