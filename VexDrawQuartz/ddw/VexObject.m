//
//  VexObject.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "VexObject.h"
#import "Timeline.h"

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
        _definitions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
