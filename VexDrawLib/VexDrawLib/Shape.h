//
//  Shape.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>

@interface Shape : NSObject

@property (nonatomic) int strokeIndex;
@property (nonatomic) int fillIndex;
@property (nonatomic) int pathIndex;

-(id) initWithStrokeIndex:(int)strokeIndex fillIndex:(int)fillIndex pathIndex:(int) pathIndex;

@end
