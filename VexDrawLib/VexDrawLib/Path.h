//
//  Path.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-21.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface Path : NSObject

@property (nonatomic) CGMutablePathRef segments;

-(id) initWithSegments:(CGMutablePathRef) segments;

@end
