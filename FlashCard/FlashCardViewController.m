//
//  FlashCardViewController.m
//  FlashCard
//
//  Created by Richard on 3/29/13.
//  Copyright (c) 2013 Richard. All rights reserved.
//

#import "FlashCardViewController.h"

@interface FlashCardViewController ()

@property (nonatomic) BOOL gameStarted;
@property (nonatomic) NSUInteger clicks;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonList;
@property (nonatomic) NSUInteger buttonsToPlayWith;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation FlashCardViewController

@synthesize buttonsToPlayWith = _buttonsToPlayWith;

- (void)enableActiveButtons {
	for (int i = 0; i < self.buttonsToPlayWith; i++) {
		UIButton *button = self.buttonList[i];
		[self showButton:button];
	}
}

- (void)setButtonsToPlayWith:(NSUInteger)buttonsToPlayWith {
	[self hideButtons:self.buttonList];
	_buttonsToPlayWith = buttonsToPlayWith;
	[self enableActiveButtons];
	NSLog(@"Playing with %d buttons.", _buttonsToPlayWith);
}

- (NSUInteger)buttonsToPlayWith {
	return _buttonsToPlayWith;
}

- (void)showButton:(UIButton *)button {
	button.enabled = YES;
	button.alpha = 1.0;
}

- (void)hideButton:(UIButton *)button {
	button.enabled = NO;
	button.alpha = 0.0;
}

- (void)showButtons:(NSArray *)buttonList {
	for (UIButton *button in buttonList) {
		[self showButton:button];
	}
}

- (void)hideButtons:(NSArray *)buttonList {
	for (UIButton *button in buttonList) {
		[self hideButton:button];
	}
}

- (void)pickNumberOfButtons:(UISegmentedControl *)sender forEvent:(UIEvent *)event {
	NSInteger index = [sender selectedSegmentIndex];
	NSLog(@"Segment %d selected.", index);
	[self setButtonsToPlayWith:index];
}

- (void)disableButtons:(NSArray *)buttonList {
	for (UIButton *button in self.buttonList) {
		[button setEnabled:NO];
	}
}

- (void)enableButtons:(NSArray *)buttonList {
	for (UIButton *button in buttonList) {
		[button setEnabled:YES];
		[button setAlpha:1.0];
	}
}

- (IBAction)showTitle:(UIButton *)sender {
	if (self.gameStarted == NO) {
		self.gameStarted = YES;
		[self.segmentedControl setEnabled:NO];
		NSLog(@"Game started!");
	}
	NSLog(@"Button clicked. Click total: %d", self.clicks++);
	
	[sender setTitle:@"Hi!" forState:UIControlStateNormal];
	[sender setAlpha:.3];
	
	[self disableButtons:self.buttonList];
	
	[NSTimer scheduledTimerWithTimeInterval:1.7 target:self selector:@selector(hideTitle:) userInfo:sender repeats:NO];
}

- (void)hideTitle:(NSTimer *)timer {
	UIButton *button = timer.userInfo;
	[button setTitle:@"Button" forState:UIControlStateNormal];
	[button setAlpha:1.0];
	[self enableActiveButtons];
}

- (IBAction)resetGame:(UIButton *)sender {
	[self.segmentedControl setEnabled:YES];
	[self setButtonsToPlayWith: [self.segmentedControl selectedSegmentIndex]];
	[self setGameStarted:NO];
}

//
// Provided by XCode template
//
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self.segmentedControl addTarget:self action:@selector(pickNumberOfButtons:forEvent:) forControlEvents:UIControlEventValueChanged];
	[self resetGame:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
