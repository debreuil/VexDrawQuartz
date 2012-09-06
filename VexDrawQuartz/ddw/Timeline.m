//
//  Timeline.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "Timeline.h"
#import "Instance.h"

@implementation Timeline

@synthesize instances = _instances;

-(id) init
{
    self = [super init];
    if(self)
    {
        self.isTimeline = true;
        _instances = [[NSMutableArray alloc] init];
    }
    return self;
}

+(void) drawTimeline:(Timeline *) tl withVexObject:(VexObject *)vo
{    
    for(Instance *inst in tl.instances)
    {
        //Instance.drawInstance(inst, vo);
    }
}

@end
