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

-(id) initWithColor:(CGColorRef)theColor lineWidth:(float)theLineWidth
{
    self = [super init];
    if(self)
    {
        _color = theColor;
        _lineWidth = theLineWidth;
    }
    return self;
}

@end
