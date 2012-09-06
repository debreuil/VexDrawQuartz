//
//  VexDrawBinaryReader.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-03.
//
//

#import <Foundation/Foundation.h>
#import "VexObject.h"
#import "Symbol.h"

extern int const TWIPS;

@interface VexDrawBinaryReader : NSObject

-(VexObject *) createVexObjectFromData:(NSData *) data;

@end
