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
@synthesize path = _path;

-(id) initWithStrokeIndex:(int)strokeIndex fillIndex:(int)fillIndex path:(CGMutablePathRef) path;
{
    self = [super init];
    if(self)
    {
        _strokeIndex = strokeIndex;
        _fillIndex = fillIndex;
        _path = path;        
    }
    return self;    
}

@end
