//
//  VexDrawTag.h
//  VexDrawQuartz
//
//  Created by admin on 12-09-02.
//
//

#import <Foundation/Foundation.h>

enum
{
    None                            = 0x00,
        
    Header							= 0x01,
        
    StrokeList						= 0x05,
    SolidFillList					= 0x06,
    GradientFillList				= 0x07,
        
    ReplacementSolidFillList		= 0x09,
    ReplacementGradientFillList     = 0x0A,
    ReplacementStrokeList			= 0x0B,
        
    SymbolDefinition				= 0x10,
    TimelineDefinition				= 0x11,        
        
    End                             = 0xFF

};
typedef NSUInteger VexDrawTag;
