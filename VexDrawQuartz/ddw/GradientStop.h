//
//  GradientStop.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-04.
//
//

#import <Foundation/Foundation.h>


@interface GradientStop : NSObject

-(id) initWithColor:(CGColorRef) color ratio:(float) ratio;

@property CGColorRef color;
@property float ratio;

@end
