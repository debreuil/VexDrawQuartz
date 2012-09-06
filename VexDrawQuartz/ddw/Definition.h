//
//  Definition.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>

@interface Definition : NSObject

@property (nonatomic, retain) NSNumber *definitionId;
@property (nonatomic, assign) BOOL isTimeline;
@property (nonatomic, assign) CGRect bounds;

@end
