//
//  SolidFill.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>
#import "Fill.h"

@interface SolidFill : Fill

@property (nonatomic, readonly) CGColorRef color;

-(id) initWithColor:(CGColorRef)color;
@end
