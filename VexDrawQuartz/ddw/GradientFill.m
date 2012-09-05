//
//  GradientFill.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "GradientFill.h"
#import "GradientStop.h"
#import "Fill.h"


@implementation GradientFill

@synthesize stops = _stops;

-(id) init
{
    self = [super init];
    if(self)
    {
        _stops = [[NSMutableArray alloc] init];
    }
    return self;
    
}
-(id) initWithGradientType:(GradientType) theType gradientLine:(GradientLine) theLine
{
    self = [self init];
    if(self)
    {
        type = theType;
        line = theLine;
    }
    return self;
}

- (NSString *)description
{
    NSString *s = [NSString stringWithFormat:@"grad: %d stops: %d", type, self.stops.count ];
    if(self.stops.count > 0)
    {
        GradientStop *stop = [self.stops objectAtIndex:0];
        s = [NSString stringWithFormat:@"%@ firstCol: #%@", s, stop.color];
    }
    return s;
}
@end
