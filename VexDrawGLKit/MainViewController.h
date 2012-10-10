
#import <UIKit/UIKit.h>
#import <GLKit/GLKViewController.h>

@interface MainViewController : GLKViewController

@property (strong, nonatomic) EAGLContext *context;

- (IBAction)parseVexObjects;

@end
