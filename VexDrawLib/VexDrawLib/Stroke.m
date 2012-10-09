//
//  Stroke.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "Stroke.h"

@implementation Stroke

@synthesize color = _color;
@synthesize lineWidth = _lineWidth;

-(id) initWithColor:(CGColorRef)color lineWidth:(float)lineWidth
{
    self = [super init];
    if(self)
    {
        _color = color;
        _lineWidth = lineWidth;
    }
    return self;
}

@end
