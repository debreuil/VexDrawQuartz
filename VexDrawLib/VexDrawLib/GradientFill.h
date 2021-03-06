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

@property (nonatomic, strong) NSMutableArray *stops;
@property (nonatomic) GradientType type;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic, readonly) CGGradientRef gradient;

@end
