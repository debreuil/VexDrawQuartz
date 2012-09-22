//
//  Path.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-21.
//
//

#import <Foundation/Foundation.h>

@interface Path : NSObject

@property (nonatomic, assign) CGMutablePathRef segments;

-(id) initWithSegments:(CGMutablePathRef) segments;

@end
