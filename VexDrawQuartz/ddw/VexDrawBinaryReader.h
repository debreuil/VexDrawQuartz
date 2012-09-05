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

-(VexDrawBinaryReader*) initWithData:(NSData *) data usingVexObject:(VexObject *) vo;

-(Symbol *) parseSymbol:(VexObject *) vo;


-(void) flushBits;
-(unsigned int) readByte;
-(BOOL) readBit;
-(int) readNBitValue;
-(CGRect) readNBitRect;
-(int) readNBitInt:(int)nBits;
-(int) readNBits:(int) nBits;
-(int) readNBits:(int) nBits startValue:(int) result;
-(CGColorRef) readAndCreateColor:(int) nBits;

@end
