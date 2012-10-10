//
//  Timeline.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Definition.h"
#import "VexObject.h"

@interface Timeline : Definition

@property (nonatomic, retain) NSMutableArray *instances;

+(void) drawTimeline:(Timeline *) tl intoLayer: (CALayer *)layer;

@end
