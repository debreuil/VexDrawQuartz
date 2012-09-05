//
//  QuartzView.m
//  VexDrawQuartz
//
//  Created by admin on 12-08-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuartzView.h"

#import <QuartzCore/CoreAnimation.h>

@implementation QuartzView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

UIImage *myImage;

- (void)renderVexImage
{
    //[self setHidden:NO];
    CGSize screenSize = self.frame.size;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(   nil, 
                                                 screenSize.width, 
                                                 screenSize.height, 
                                                 8, 
                                                 4*(int)screenSize.width,
                                                 colorSpaceRef, 
                                                 kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, 0.0, screenSize.height);
    CGContextScaleCTM(context, 1.0, -1.0);  
    CGContextSetLineWidth(context, 2.0);        
    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};    
    CGColorRef color = CGColorCreate(colorSpaceRef, components);    
    CGContextSetStrokeColorWithColor(context, color);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, screenSize.width, screenSize.height);    
    CGContextStrokePath(context);
    
    
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    myImage = [UIImage imageWithCGImage:cgImage];
    
    CGColorSpaceRelease(colorSpaceRef);
    CGColorRelease(color);
    CGImageRelease(cgImage);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);     
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor lightGrayColor] setFill];
    CGContextFillRect(context, rect);
    
    if(myImage == nil)
    {
        [self renderVexImage];
    }
    
    [myImage drawAtPoint:CGPointMake(10, 10)];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetLineWidth(context, 2.0);
//    
//    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
//    
//    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
//    
//    CGColorRef color = CGColorCreate(colorspace, components);
//    
//    CGContextSetStrokeColorWithColor(context, color);
//    
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, 300, 400);
//    
//    CGContextStrokePath(context);
//    CGColorSpaceRelease(colorspace);
//    CGColorRelease(color);
//}

@end
