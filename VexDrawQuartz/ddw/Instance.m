#import "Instance.h"
#import "Definition.h"
#import "VexObject.h"
#import "Timeline.h"
#import "Symbol.h"

@interface Instance()
@end



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


-(void) createLayerInLayer:(CALayer *) parent
{
    CALayer *calayer = nil;
    Definition *def = [self.vo.definitions objectForKey:self.definitionId];
    
    if([def isKindOfClass:[Symbol class]])
    {    
        Symbol *symbol = (Symbol *)def;
        
        calayer = [CALayer layer];        
        CGImageRef img = [symbol createCGImageAtScaleX:self.scaleX scaleY:self.scaleY];        
        [calayer setFrame:CGRectMake(0, 0, CGImageGetWidth(img), CGImageGetHeight(img))];
        //[calayer setBackgroundColor:[UIColor yellowColor].CGColor];
        [parent addSublayer:calayer];
        
        calayer.contents = (__bridge id)img;
        calayer.position = CGPointMake(self.x,self.y);
        
    }
    else if([def isKindOfClass:[Timeline class]])
    {
        CATransformLayer *tlayer = [Timeline drawTimeline:(Timeline *)def intoLayer:parent];
        tlayer.position = CGPointMake(self.x, self.y);
    }
}


@end






