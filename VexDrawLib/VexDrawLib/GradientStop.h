//
//  GradientStop.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-04.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface GradientStop : NSObject

-(id) initWithColor:(CGColorRef) color ratio:(float) ratio;

@property (nonatomic, readonly) CGColorRef color;
@property (readwrite) float ratio;

@end
