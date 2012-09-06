//
//  Instance.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>

@interface Instance : NSObject

@property (nonatomic, assign) int definitionId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) int instanceId;

@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float scaleX;
@property (nonatomic, assign) float scaleY;
@property (nonatomic, assign) float rotation;
@property (nonatomic, assign) float shear;

@property (nonatomic, assign) BOOL hasScale;
@property (nonatomic, assign) BOOL hasRotation;
@property (nonatomic, assign) BOOL hasShear;


@end
