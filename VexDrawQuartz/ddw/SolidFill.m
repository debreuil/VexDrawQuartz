//
//  SolidFill.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "SolidFill.h"

@implementation SolidFill

@synthesize color = _color;

-(id) initWithColor:(CGColorRef)theColor
{
    self = [super init];
    if(self)
    {
        _color = theColor;
    }
    return self;
}
@end
