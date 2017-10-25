//
//  ViewController.h
//  ParallaxMenu
//
//  Created by Philipp Homann on 24.10.17.
//  Copyright © 2017 Exozet Berlin GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIView *viewShadowOverlay;
@property (weak, nonatomic) IBOutlet UIView *viewMenu;

- (IBAction)onBtnMenuTouched:(id)sender;

@end

