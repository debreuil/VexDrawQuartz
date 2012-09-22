//
//  Path.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-21.
//
//

#import "Path.h"

@implementation Path

@synthesize segments = _segments;

-(id) initWithSegments:(CGMutablePathRef) segments
{    
    self = [super init];
    if(self)
    {
        _segments = segments;
    }
    return self;
}
@end
