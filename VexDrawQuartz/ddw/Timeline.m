//
//  Timeline.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "Timeline.h"

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

@end
