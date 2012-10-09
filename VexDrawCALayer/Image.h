//
//  Image.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Definition.h"


@interface Image : Definition

@property (nonatomic, retain) NSString *path;

-(id) initWithPath:(NSString *) path;
- (CGImageRef)getImage;

@end
