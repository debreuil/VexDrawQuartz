#import "Instance.h"
#import "Definition.h"
#import "VexObject.h"
#import "Timeline.h"
#import "Symbol.h"
#import "Image.h"

#define degreesToRadians(x) (M_PI * x / 180.0)


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
-(id) initWithId:(int) instId
{
    self = [super init];
    if(self)
    {
        self.scaleX = 1;
        self.scaleY = 1;
        self.instanceId = [NSNumber numberWithInt:instId];
        if(instId >= instanceCounter)
        {
            instanceCounter = instId + 1;
        }
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"id: %d x:%d y: %d", (int)self.definitionId, (int)self.x, (int)self.y];
}

-(CALayer *) getRootLayerOf:(CALayer *) layer
{
    CALayer *result = layer;
    while (result.superlayer)
    {
        result = result.superlayer;        
    }
    return result;
}
-(void) createLayerInLayer:(CALayer *) parent
{
    CALayer *calayer = nil;
    Definition *def = [self.vo.definitions objectForKey:self.definitionId];
    
    if([def isKindOfClass:[Symbol class]])
    {
        Symbol *symbol = (Symbol *)def;
        calayer = [CALayer layer];
        [parent addSublayer:calayer];
        
		float offsetX = (-def.bounds.origin.x / def.bounds.size.width);
		float offsetY = (-def.bounds.origin.y / def.bounds.size.height);
        [calayer setAnchorPoint:CGPointMake(offsetX, offsetY)];
        
        CALayer *root = [self getRootLayerOf:parent];
        CGRect srect = CGRectMake(0, 0, 1.0, 1.0);
        srect = [parent convertRect:srect toLayer:root];
        float scaleX = srect.size.width;
        float scaleY = srect.size.height;
        
        CGImageRef img = [symbol createCGImageAtScaleX: scaleX scaleY:scaleY];
        
        [calayer setFrame:CGRectMake(0, 0, CGImageGetWidth(img), CGImageGetHeight(img))];
        calayer.position = CGPointMake(-offsetX, -offsetY);
        //[calayer setBackgroundColor:[UIColor yellowColor].CGColor];
        calayer.contents = (__bridge id)img;        
        
    }
    else if([def isKindOfClass:[Image class]])
    {
        Image *image = (Image *)def;
        calayer = [CALayer layer];
        [parent addSublayer:calayer];
        [calayer setAnchorPoint:CGPointMake(0, 0)];
        
        CGImageRef img = [image getImage];
        
        [calayer setFrame:CGRectMake(0, 0, CGImageGetWidth(img), CGImageGetHeight(img))];
        
        calayer.contents = (__bridge id)img;
        
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DScale(transform, self.scaleX, self.scaleY, 1);
        transform = CATransform3DRotate(transform, self.rotation * M_PI / 180.0, 0, 0, 1.0);
        
        [CATransaction begin];
        calayer.transform = transform;
        calayer.position = CGPointMake(self.x, self.y);
        [CATransaction commit];

    }
    else if([def isKindOfClass:[Timeline class]])
    {            
        CATransformLayer *tlayer = [CATransformLayer layer];
        [parent addSublayer:tlayer];        
        
		float offsetX = -def.bounds.origin.x / def.bounds.size.width;
		float offsetY = -def.bounds.origin.y / def.bounds.size.height;
        [tlayer setAnchorPoint:CGPointMake(offsetX, offsetY)];

        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DScale(transform, self.scaleX, self.scaleY, 1);
        
        [CATransaction begin];
        tlayer.transform = transform;
        [CATransaction commit];
        
        [Timeline drawTimeline:(Timeline *)def intoLayer:tlayer];
        
        transform = CATransform3DIdentity;
        //transform = CATransform3DScale(transform, -self.scaleX, -self.scaleY, 1);
        transform = CATransform3DRotate(transform, self.rotation * M_PI / 180.0, 0, 0, 1.0);
        
        [CATransaction begin];
        tlayer.transform = transform;
        tlayer.position = CGPointMake(self.x, self.y);
        [CATransaction commit];
    }
}


@end






