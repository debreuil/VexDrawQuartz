//
//  Symbol.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "Symbol.h"

@implementation Symbol

@synthesize shapes = _shapes;

-(id) init
{
    self = [super init];
    if(self)
    {
        self.isTimeline = false;
        _shapes = [[NSMutableArray alloc] init];
    }
    return self;    
}

@end
