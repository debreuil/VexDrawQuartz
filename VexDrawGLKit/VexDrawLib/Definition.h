//
//  Definition.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "VexObject.h"

@class Symbol;

@interface Definition : NSObject

@property (nonatomic, weak) VexObject *vo;

@property (nonatomic, retain) NSNumber *definitionId;
@property (nonatomic, assign) BOOL isTimeline;
@property (nonatomic, assign) CGRect bounds;

-(Symbol *) getWrappedSymbolOrSelf;

@end
