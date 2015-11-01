//
//  RWTContainerViewController.m
//  RedAlert
//
//  Created by Main Account on 3/17/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTContainerViewController.h"
#import "RWTViewController.h"

@interface RWTContainerViewController ()

@property (strong, nonatomic) RWTViewController *rVc;
@property (strong, nonatomic) RWTViewController *gVc;
@property (strong, nonatomic) RWTViewController *bVc;

@end

@implementation RWTContainerViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"EmbedRed"]) {
    _rVc = (RWTViewController *)segue.destinationViewController;
    _rVc.rMult = 1.0;
  }
  if ([segue.identifier isEqualToString:@"EmbedGreen"]) {
    _gVc = (RWTViewController *)segue.destinationViewController;
    _gVc.gMult = 1.0;
  }
  if ([segue.identifier isEqualToString:@"EmbedBlue"]) {
    _bVc = (RWTViewController *)segue.destinationViewController;
    _bVc.bMult = 1.0;
  }
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
  _rVc.secsPerFlash = sender.value;
  _gVc.secsPerFlash = sender.value;
  _bVc.secsPerFlash = sender.value;
}


@end
