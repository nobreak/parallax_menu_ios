//
//  ViewController.m
//  ParallaxMenu
//
//  Created by Philipp Homann on 24.10.17.
//  Copyright © 2017 Exozet Berlin GmbH. All rights reserved.
//

#import "ViewController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()
@property (assign) BOOL isMenuOpen;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.isMenuOpen = NO;
    [self setAnchorPoint:CGPointMake(1, 0.5) forView:_viewMain];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = _viewShadowOverlay.bounds;
    gradient.startPoint = CGPointMake(0.6,0.5);
    gradient.endPoint = CGPointMake(0,0.5);
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor grayColor].CGColor];
    
    [_viewShadowOverlay.layer insertSublayer:gradient atIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onBtnMenuTouched:(id)sender {
    if (!self.isMenuOpen)
    {
        [self openMenu];
    }
    else
    {
        [self closeMenu];
    }
}

- (void) openMenu
{
    [self setAnchorPoint:CGPointMake(1.0, 0.5) forView:_viewMain];
    CGFloat angle = -45.0f;
    
    CATransform3D t1 = CATransform3DIdentity;
    //Add perspective!!!
    t1.m34 = 1.0/ -1000;
    
    t1 = CATransform3DRotate(t1, DEGREES_TO_RADIANS(angle), 0, 1, 0);
    [UIView animateWithDuration:0.5 animations:^(void){
        _viewMain.layer.transform = t1;
        _viewShadowOverlay.alpha = 1.0f;
        _viewMain.frame = CGRectMake(_viewMain.frame.origin.x+2, _viewMain.frame.origin.y, _viewMain.frame.size.width, _viewMain.frame.size.height);
    } ];
    
    _isMenuOpen = YES;
 
}

- (void) closeMenu
{
    CGFloat angle = 0.0f;
    
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 0;
    
    t1 = CATransform3DRotate(t1, DEGREES_TO_RADIANS(angle), 0, 1, 0);
    [UIView animateWithDuration:0.5 animations:^(void){
        _viewMain.layer.transform = t1;
        _viewShadowOverlay.alpha = 0.0f;
        _viewMain.frame = _viewBackground.frame;
    }completion:^(BOOL fnished){
        [self setAnchorPoint:CGPointMake(0.5, 0.5) forView:_viewMain];
    }];
    
    _isMenuOpen = NO;

}




-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}
@end
