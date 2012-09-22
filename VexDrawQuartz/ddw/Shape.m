//
//  Shape.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "Shape.h"

@implementation Shape

@synthesize strokeIndex = _strokeIndex;
@synthesize fillIndex = _fillIndex;
@synthesize pathIndex = _pathIndex;

-(id) initWithStrokeIndex:(int)strokeIndex fillIndex:(int)fillIndex pathIndex:(int) pathIndex;
{
    self = [super init];
    if(self)
    {
        _strokeIndex = strokeIndex;
        _fillIndex = fillIndex;
        _pathIndex = pathIndex;        
    }
    return self;    
}

@end
