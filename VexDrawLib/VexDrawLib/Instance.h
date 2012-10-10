//
//  Instance.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>
#import "VexObject.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <UIKit/UIKit.h>


@interface Instance : NSObject

@property (nonatomic, weak) VexObject *vo;

@property (nonatomic, strong) NSNumber *definitionId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *instanceId;

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float scaleX;
@property (nonatomic) float scaleY;
@property (nonatomic) float rotation;
@property (nonatomic) float shear;

@property (nonatomic) BOOL hasScale;
@property (nonatomic) BOOL hasRotation;
@property (nonatomic) BOOL hasShear;

-(id) initWithId:(int) instId;
-(void) createLayerInLayer:(CALayer *) parent;

@end
