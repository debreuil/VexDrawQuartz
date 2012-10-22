
#import "BasicSprite.h"

typedef struct {
    CGPoint geometryVertex;
    CGPoint textureVertex;
} TexturedVertex;

typedef struct {
    TexturedVertex bl;
    TexturedVertex br;
    TexturedVertex tl;
    TexturedVertex tr;
} TexturedQuad;


@interface BasicSprite()
    @property (strong) GLKBaseEffect * effect;
    @property (assign) TexturedQuad quad;
    @property (strong) GLKTextureInfo * textureInfo;
@end


@implementation BasicSprite

@synthesize instance = _instance;
@synthesize effect = _effect;
@synthesize quad = _quad;
@synthesize textureInfo = _textureInfo;

- (id)initWithInstance:(Instance *)instance effect:(GLKBaseEffect *)effect
{
    if ((self = [super init]))
    {
        self.instance = instance;
        self.effect = effect;
        NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithBool:YES],
                                  GLKTextureLoaderOriginBottomLeft, nil];
        NSError * error;
//        self.textureInfo = [GLKTextureLoader textureWithCGImage:image options:options error:&error];
//        if (self.textureInfo == nil)
//        {
//            NSLog(@"Error loading file: %@", [error localizedDescription]);
//            return nil;
//        }
//        
//        CGFloat w = self.textureInfo.width;
//        CGFloat h = self.textureInfo.height;
//        
//        self.contentSize = CGSizeMake(instance.width, instance.height);
//        
//        TexturedQuad newQuad;
//        newQuad.bl.geometryVertex = CGPointMake(0, 0);
//        newQuad.br.geometryVertex = CGPointMake(w, 0);
//        newQuad.tl.geometryVertex = CGPointMake(0, h);
//        newQuad.tr.geometryVertex = CGPointMake(w, h);
//        
//        newQuad.bl.textureVertex = CGPointMake(0, 0);
//        newQuad.br.textureVertex = CGPointMake(1, 0);
//        newQuad.tl.textureVertex = CGPointMake(0, 1);
//        newQuad.tr.textureVertex = CGPointMake(1, 1);
//        self.quad = newQuad;
    }
    return self;
}

- (GLKMatrix4) fullMatrix:(GLKMatrix4) parentMatrix
{
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
//    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, 0);
    return modelMatrix;
}

- (void)renderWithParentMatrix:(GLKMatrix4) parentMatrix
{
    self.effect.texture2d0.name = self.textureInfo.name;
    self.effect.texture2d0.enabled = YES;
    
    self.effect.transform.modelviewMatrix = [self fullMatrix:parentMatrix];
    
    [self.effect prepareToDraw];
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    long offset = (long)&_quad;
    
    glVertexAttribPointer(GLKVertexAttribPosition,
                          2,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(TexturedVertex),
                          (void *) (offset + offsetof(TexturedVertex, geometryVertex)));
    
    glVertexAttribPointer(GLKVertexAttribTexCoord0,
                          2, GL_FLOAT,
                          GL_FALSE,
                          sizeof(TexturedVertex),
                          (void *) (offset + offsetof(TexturedVertex, textureVertex)));
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
}
@end












