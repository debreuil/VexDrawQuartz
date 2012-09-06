//
//  TestController.m
//  VexDrawQuartz
//
//  Created by admin on 12-08-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestController.h"
#import "QuartzView.h"
#import "VexObject.h"
#import "VexDrawBinaryReader.h"

@implementation TestController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization                
    }
    return self;
}

- (void)loadView
{
    QuartzView *rootView = [[QuartzView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = rootView;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testData" ofType:@"dat"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    VexDrawBinaryReader *br = [[VexDrawBinaryReader alloc] init];
    VexObject *vo = [br createVexObjectFromData:data];    
    [rootView renderVexImageWithTimeline:[vo.definitions objectForKey:[NSNumber numberWithInt:3]]];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
