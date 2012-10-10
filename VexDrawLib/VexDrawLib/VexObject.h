//
//  VexObject.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>

@interface VexObject : NSObject

@property (nonatomic, strong) NSMutableDictionary *definitionNameTable;
@property (nonatomic, strong) NSMutableDictionary *instanceNameTable;
@property (nonatomic, strong) NSMutableArray *pathTable;

@property (nonatomic, strong) NSMutableArray *strokes;
@property (nonatomic, strong) NSMutableArray *fills;
@property (nonatomic, strong) NSMutableDictionary *definitions;

@end
