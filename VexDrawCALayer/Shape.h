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
@property (nonatomic, assign) int pathIndex;

-(id) initWithStrokeIndex:(int)strokeIndex fillIndex:(int)fillIndex pathIndex:(int) pathIndex;

@end
