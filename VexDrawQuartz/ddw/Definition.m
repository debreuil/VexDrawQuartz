//
//  Definition.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "Definition.h"
#import "Timeline.h"
#import "Symbol.h"

@implementation Definition

@synthesize vo = _vo;
@synthesize definitionId = _definitionId;
@synthesize isTimeline = _isTimeline;
@synthesize bounds = _bounds;


-(Symbol *) getWrappedSymbolOrSelf
{
    Symbol *result = nil;
    if([self isKindOfClass:[Symbol class]])
    {
        result = (Symbol *)self;
    }
    else if([self isKindOfClass:[Timeline class]])
    {
        Timeline *tl = (Timeline *)self;
        if(tl.instances.count == 1)
        {
            Definition *def2 = [tl.instances objectAtIndex:0];
            if([def2 isKindOfClass:[Symbol class]])
            {
                result = [tl.instances objectAtIndex:0];
            }
        }
        
    }
    return result;
}

@end
