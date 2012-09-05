//
//  GradientFill.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>
#import "Fill.h"


enum
{
    Linear,
    Radial
};
typedef NSUInteger GradientType;

typedef struct GradientLine
{
    float p0x;
    float p0y;
    float p1x;
    float p1y;
} GradientLine;


@interface GradientFill : Fill
{
    GradientType type;
    GradientLine line;
}

-(id) initWithGradientType:(GradientType) type gradientLine:(GradientLine) line;

@property (nonatomic, retain) NSMutableArray *stops;

@end
