//
//  GradientFill.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Fill.h"


enum
{
    LinearGradient,
    RadialGradient
};
typedef NSUInteger GradientType;


@interface GradientFill : Fill

-(id) initWithGradientType:(GradientType) type startPoint:(CGPoint) startPoint endPoint:(CGPoint) endPoint;

@property (nonatomic, retain) NSMutableArray *stops;
@property (nonatomic, assign) GradientType type;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, readonly) CGGradientRef gradient;

@end
