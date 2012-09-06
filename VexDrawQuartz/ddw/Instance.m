//
//  Instance.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import "Instance.h"

@implementation Instance

static int instanceCounter = 0;

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
        self.instanceId = instanceCounter++;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"id: %d x:%d y: %d", self.definitionId, (int)self.x, (int)self.y];
}

@end
