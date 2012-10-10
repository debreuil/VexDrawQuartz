
#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface BasicSprite : NSObject

@property (assign) GLKVector2 position;
@property (assign) CGSize contentSize;

- (id)initWithImage:(CGImageRef)image effect:(GLKBaseEffect *)effect;
- (void)render;


@end
