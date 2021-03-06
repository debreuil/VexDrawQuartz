//
//  Symbol.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>
#import "Definition.h"
#import "Instance.h"

@interface Symbol : Definition

@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, strong) NSMutableArray *shapes;


+(void) drawSymbol:(Symbol *)symbol atScaleX:(float)scaleX yScale:(float)scaleY withContext: (CGContextRef)context;

- (CGImageRef)createCGImageAtScaleX:(float)scaleX scaleY:(float)scaleY;

@end
