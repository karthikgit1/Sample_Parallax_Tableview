//
//  ViewController.h
//  Yahoo_Digest
//
//  Created by Vy Systems - iOS1 on 10/6/14.
//  Copyright (c) 2014 Vy Systems - iOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    BOOL hidden;
    BOOL isAnimating;
    CGFloat _lastPosition;
}

@end

