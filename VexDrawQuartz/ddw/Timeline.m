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


+(CATransformLayer *) drawTimeline:(Timeline *) tl intoLayer: (CALayer *)parent
{
    CATransformLayer *tlayer = [CATransformLayer layer];
    [parent addSublayer:tlayer];
    
    for(Instance *inst in tl.instances)
    {
        [inst createLayerInLayer:tlayer];
    }
    return tlayer;
}

@end
