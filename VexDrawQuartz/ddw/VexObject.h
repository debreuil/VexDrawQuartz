//
//  VexObject.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>

@interface VexObject : NSObject

@property (nonatomic, retain) NSMutableArray *strokes;
@property (nonatomic, retain) NSMutableArray *fills;
@property (nonatomic, retain) NSMutableDictionary *definitions;

@end
