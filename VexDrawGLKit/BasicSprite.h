
#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Instance.h"

@interface BasicSprite : NSObject

@property (strong) Instance *instance;

//- (id)initWithImage:(CGImageRef)image effect:(GLKBaseEffect *)effect;
- (void)render;


@end
