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

@property (nonatomic, retain) NSMutableArray *shapes;

+(void) drawSymbol:(Symbol *)symbol withMetricsFrom:(Instance *)inst withVexObject:(VexObject *)vo;


@end
