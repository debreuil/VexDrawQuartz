//
//  Stroke.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>

@interface Stroke : NSObject
{
}

@property CGColorRef color;
@property float lineWidth;

-(id) initWithColor:(CGColorRef)color lineWidth:(float)lineWidth;

@end
