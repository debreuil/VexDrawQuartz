
#import "MainViewController.h"
#import "BasicSprite.h"
#import "VexObject.h"
#import "VexDrawBinaryReader.h"
#import "Timeline.h"
#import "Symbol.h"

@interface MainViewController()
@property (nonatomic, retain) VexObject *vexObject;
@property (strong) GLKBaseEffect * effect;
@property (strong) BasicSprite * player;

- (void) drawDefinition:(Definition *) def withMatrixStack:(GLKMatrixStackRef) mxStack;
@end

@implementation MainViewController

@synthesize vexObject = _vexObject;
@synthesize context = _context;
@synthesize player = _player;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self parseVexObjects];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context)
    {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, screenSize.width, 0, screenSize.height, -1024, 1024);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrixStackRef mxStack = GLKMatrixStackCreate(0);
    
    Definition *def = [_vexObject.definitions objectForKey:[NSNumber numberWithInt:1]];
    [self drawDefinition:def withMatrixStack:mxStack];
    
    CFRelease(mxStack);
}

- (void)update
{
}

- (void) drawDefinition:(Definition *) def withMatrixStack:(GLKMatrixStackRef) mxStack
{
    if(def.isTimeline)
    {
        Timeline *tl = (Timeline *)def;
        for (int i = 0; i < tl.instances.count; i++)
        {
            float offsetX = def.bounds.origin.x / def.bounds.size.width;
            float offsetY = def.bounds.origin.y / def.bounds.size.height;
            
            Instance *inst = [tl.instances objectAtIndex:i];
            GLKMatrix4 orgMx = GLKMatrixStackGetMatrix4(mxStack);
            float orgX = orgMx.m30 - offsetX;
            float orgY = orgMx.m31 - offsetY;
            
            GLKMatrixStackPush(mxStack);
            
            GLKMatrixStackTranslate(mxStack, -orgX, -orgY, 0);
            GLKMatrixStackScale(mxStack, inst.scaleX, inst.scaleY, 1);
            GLKMatrixStackRotate(mxStack, GLKMathDegreesToRadians(inst.rotation), 0, 0, 0);
            GLKMatrixStackTranslate(mxStack, orgX + inst.x, orgY + inst.y, 0);
            
            GLKMatrixStackPop(mxStack);
        }
    }
    else if([def isKindOfClass:[Symbol class]])
    {
        Symbol *sym = (Symbol *) def;
        CGImageRef image = [sym createCGImageAtScaleX:1 scaleY:1];
        //CGImageRetain(image);
        
        UIImage *uiImage = [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageWithCGImage:image])];
        
        //self.player = [[BasicSprite alloc] initWithImage:uiImage.CGImage effect:self.effect];
        //self.player.position = GLKVector2Make(30, 160);
    }
}

- (IBAction)parseVexObjects
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testData" ofType:@"dat"];
    NSData *vexData = [NSData dataWithContentsOfFile:filePath];
    
    VexDrawBinaryReader *br = [[VexDrawBinaryReader alloc] init];
    self.vexObject = [br createVexObjectFromData:vexData];
}

- (IBAction)drawVexObjects:(id)sender
{
    Timeline *tl = [self.vexObject.definitions objectForKey:[NSNumber numberWithInt:1]];    
    [Timeline drawTimeline:tl intoLayer:self.view.layer];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1, .8, .7, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    [self.player render];
}



@end
