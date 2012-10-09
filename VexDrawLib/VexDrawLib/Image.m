//
//  Image.m
//  VexDrawQuartz
//
//  Created by admin on 12-09-24.
//
//

#import "Image.h"

@implementation Image

@synthesize path = _path;

UIImage *img;
CGImageRef imageRef;


-(id) initWithPath:(NSString *) path
{
    self = [super init];
    if(self)
    {
        self.isTimeline = false;
        _path = path;
        NSArray *segs = [path componentsSeparatedByString:@"."];
        NSString* imageName = [[NSBundle mainBundle] pathForResource:[segs objectAtIndex:0] ofType:[segs objectAtIndex:1]];
        //NSImage* imageObj = [[NSImage alloc] initWithContentsOfFile:imageName];
        img = [UIImage imageWithContentsOfFile:imageName];
        imageRef = img.CGImage;
    }
    return self;
}

- (CGImageRef)getImage
{
    return imageRef;
}


@end
