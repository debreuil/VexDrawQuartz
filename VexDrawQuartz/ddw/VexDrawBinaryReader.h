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
{
    
    const unsigned char *rawData;
	unsigned int index;
	unsigned int bit;       
	unsigned int dataLen;
    
	unsigned int fillIndexNBits;
	unsigned int strokeIndexNBits;
	
}

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
-(CGColorRef) readColor:(int) nBits;

@end
