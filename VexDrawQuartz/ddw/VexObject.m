//
//  VexObject.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "VexObject.h"

@implementation VexObject

@synthesize strokes = _strokes;
@synthesize fills = _fills;
@synthesize definitions = _definitions;

-(id) init
{
    self = [super init];
    if(self)
    {
        _strokes = [[NSMutableArray alloc] init];
        _fills = [[NSMutableArray alloc] init];
        _definitions = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)dealloc
{
    [_strokes removeAllObjects];
    [_fills removeAllObjects];
    [_definitions removeAllObjects];
}

@end
