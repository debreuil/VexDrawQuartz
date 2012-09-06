//
//  Instance.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "Instance.h"
#import "Definition.h"
#import "VexObject.h"
#import "Timeline.h"
#import "Symbol.h"

@implementation Instance

static int instanceCounter = 0;

@synthesize vo = _vo;

@synthesize definitionId = _definitionId;
@synthesize name = _name;
@synthesize instanceId = _instanceId;

@synthesize x = _x;
@synthesize y = _y;
@synthesize scaleX = _scaleX;
@synthesize scaleY = _scaleY;
@synthesize rotation = _rotation;
@synthesize shear = _shear;

@synthesize hasScale = _hasScale;
@synthesize hasRotation = _hasRotation;
@synthesize hasShear = _hasShear;

-(id) init
{
    self = [super init];
    if(self)
    {
        self.scaleX = 1;
        self.scaleY = 1;
        self.instanceId = [NSNumber numberWithInt:instanceCounter++];
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"id: %d x:%d y: %d", (int)self.definitionId, (int)self.x, (int)self.y];
}

+(void) drawInstance:(Instance *) inst  withContext: (CGContextRef)context
{
    
    //NSString *divClass = (inst.name == nil || inst.name == @"") ?
    //                        [NSString stringWithFormat:@"inst_%d", (int)inst.instanceId] : inst.name;
    
    //var div:HTMLDivElement = vo.pushDiv(divClass);
    float offsetX = 0;
    float offsetY = 0;
    
    Definition *def = [inst.vo.definitions objectForKey:inst.definitionId];
    
    if(def.isTimeline)
    {
        Timeline *tl = (Timeline *)def;
        
        if (tl.instances.count > 1 || (tl.instances.count == 1 && [tl isKindOfClass:[Timeline class]]) )
        {
            [Timeline drawTimeline: (Timeline *)tl withContext:context];
        }
        else
        {
            NSNumber *defId = ((Instance *)[tl.instances objectAtIndex:0]).definitionId;
            Symbol *symbol = (Symbol *)[inst.vo.definitions objectForKey:defId];
            CGRect bnds = symbol.bounds;
            offsetX = -bnds.origin.x * inst.scaleX;
            offsetY = -bnds.origin.y * inst.scaleY;
            
            [Symbol drawSymbol:symbol withMetricsFrom:inst withContext:context];
        }
    }
    else
    {
        // doesn't normally happen
        [Symbol drawSymbol:(Symbol *)def withMetricsFrom:inst withContext:context];
    }
    
    //vo.transformObject(div, inst, offsetX, offsetY);
    
    //vo.popDiv();
     
}

@end






