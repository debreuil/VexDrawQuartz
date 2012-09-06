//
//  Shape.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>

@interface Shape : NSObject

@property (nonatomic, assign) int strokeIndex;
@property (nonatomic, assign) int fillIndex;
@property (nonatomic, assign) CGMutablePathRef path;

-(id) initWithStrokeIndex:(int)strokeIndex fillIndex:(int)fillIndex path:(CGMutablePathRef) path;

@end
