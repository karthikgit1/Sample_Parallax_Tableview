//
//  ViewController.m
//  Yahoo_Digest
//
//  Created by Vy Systems - iOS1 on 10/6/14.
//  Copyright (c) 2014 Vy Systems - iOS1. All rights reserved.
//

#import "ViewController.h"





#define anim_time 0.5
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scv1;
@property (weak, nonatomic) IBOutlet UIView *floatingView;
@property (strong, nonatomic) IBOutlet UIView *vw1;

@end
float originalFloatingViewY;

UIButton *btnouter;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.scv1 setDelegate:self];
   // [self.scv1 setContentSize:CGSizeMake(320, 568)];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    btnouter=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnouter.frame= CGRectMake(200, 30, 60, 30);
    [btnouter setTitle:@"Ok" forState:UIControlStateNormal];
    [btnouter addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnouter];
}

-(void)buttonAction
{
    NSLog(@"Btn is pressed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)updateFloatingViewFrame
{
    CGPoint contentOffset = self.scv1.contentOffset;
    
    // The floating view should be at its original position or at top of
    // the visible area, whichever is lower.
    CGFloat y = MAX(contentOffset.y, originalFloatingViewY);
    
    CGRect frame = self.floatingView.frame;
    if (y != frame.origin.y) {
        frame.origin.y = y;
        self.floatingView.frame = frame;
    }
}

#pragma mark - 跳转
/*
-(void) rightOnClick:(id) sender{
    Anim2ViewController *anim = [[Anim2ViewController alloc] init];
    [self.navigationController pushViewController:anim animated:YES];
}
*/
#pragma mark - 下拉、隐藏效果

-(void) showView
{
    NSLog( @"---->showView");
    hidden = YES;
    isAnimating = YES;
    [self performSelector:@selector(endAnimation:) withObject:nil afterDelay:anim_time];
    [UIView animateWithDuration:anim_time animations:^(void){
        [self.scv1 setFrame:CGRectMake(0, self.scv1.frame.origin.y+100, 320, self.scv1.frame.size.height)];
        [self.vw1 setFrame:CGRectMake(0, self.vw1.frame.origin.y+100, 320, self.vw1.frame.size.height)];
    }];
    
}

-(void) hideView
{
    NSLog( @"---->hideView");
    hidden = NO;
    isAnimating = YES;
    [self performSelector:@selector(endAnimation:) withObject:nil afterDelay:anim_time];
    [UIView animateWithDuration:anim_time animations:^(void)
    {
        [self.scv1 setFrame:CGRectMake(0, self.scv1.frame.origin.y-100, 320, self.scv1.frame.size.height)];
        [self.vw1 setFrame:CGRectMake(0, self.vw1.frame.origin.y-100, 320, self.vw1.frame.size.height)];
    } completion:^(BOOL finished){
        //滚动的顶部
        //        [_scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    
}

-(void)endAnimation:(id)sender
{
    @synchronized(self)
    {
        isAnimating = NO;
    }
}

#pragma mark - scroll

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"0=====Scroll-->%f",scrollView.contentOffset.y);
    
    CGFloat currentPostion = scrollView.contentOffset.y;
   // NSLog(@"currentPostion - _lastPosition is %f",currentPostion - _lastPosition);
    if (currentPostion - _lastPosition > 55 )
    {
        //NSLog(@"ScrollUp now");
        _lastPosition = currentPostion;
        
        btnouter.hidden = true;
        
        if (isAnimating)
        {
            return;
        }
        if (hidden)
        {
           // [self hideView];
            
            btnouter.hidden = true;
        }
        
    }
    else if (_lastPosition - currentPostion > 55)
    {
        //NSLog(@"ScrollDown now");
        _lastPosition = currentPostion;
        
        btnouter.hidden = false;
        if (isAnimating)
        {
            return;
        }
        if (scrollView.contentOffset.y < 0 && !hidden)
        {
           // [self showView];
            btnouter.hidden = false;
        }
        
    }
    
}



@end
