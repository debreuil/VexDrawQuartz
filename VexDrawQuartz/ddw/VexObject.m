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


//-(void) drawTimelineIndex:(NSNumber *) index withContext:(CGContextRef)context
//{
//    Definition *tlDef = [self.definitions objectForKey:index];
//    if(tlDef != nil && [tlDef isKindOfClass:[Timeline class]])
//    {
//        Timeline *tl = (Timeline *)tlDef;
//        [Timeline drawTimeline:tl withContext:context];
//    }
//}

@end
