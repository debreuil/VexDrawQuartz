//
//  TestController.m
//  VexDrawQuartz
//
//  Created by admin on 12-08-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestController.h"

@interface TestController()
    @property (nonatomic, retain) VexObject *vexObject;
@end


@implementation TestController

@synthesize vexObject = _vexObject;

- (IBAction)parseVexObjects:(id)sender
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testData" ofType:@"dat"];
    NSData *vexData = [NSData dataWithContentsOfFile:filePath];
    
    VexDrawBinaryReader *br = [[VexDrawBinaryReader alloc] init];
    self.vexObject = [br createVexObjectFromData:vexData];
    ((UIButton *)sender).hidden = YES;
}

- (IBAction)drawVexObjects:(id)sender
{    
    Timeline *tl = [self.vexObject.definitions objectForKey:[NSNumber numberWithInt:1]];
    
    [Timeline drawTimeline:tl intoLayer:self.view.layer]; 
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
