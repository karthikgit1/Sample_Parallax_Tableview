//
//  TestViewController.m
//  Yahoo_Digest
//
//  Created by Vy Systems - iOS1 on 10/7/14.
//  Copyright (c) 2014 Vy Systems - iOS1. All rights reserved.
//

#import "TestViewController.h"
#import "XHPathCover.h"
#import "HUAJIENewsCell.h"

#define anim_time 0.5
@interface TestViewController ()
@property (nonatomic, strong) XHPathCover *pathCover;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

UIButton *btnouter;
BOOL hidden;
BOOL isAnimating;
CGFloat _lastPosition;
@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 250)];
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"MenuBackground"]];
    //[_pathCover setAvatarImage:[UIImage imageNamed:@"meicon.png"]];
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack xhzengAIB", XHUserNameKey, @"1990-10-19", XHBirthdayKey, nil]];
    _pathCover.isZoomingEffect = YES;
    self.tableView.tableHeaderView = self.pathCover;
    
    __weak TestViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    [_pathCover setHandleTapBackgroundImageEvent:^{
        [wself.pathCover setBackgroundImage:[UIImage imageNamed:@"AlbumHeaderBackgrounImage"]];
    }];
    
    
    //Add Menu Button
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


- (void)_refreshing
{
    // refresh your data sources
    
    __weak TestViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wself.pathCover stopRefresh];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     static NSString *CellIdentifier = @"Cell";
     HUAJIENewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (!cell) {
     cell = [[HUAJIENewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     
     
     return cell;
     
     */
    
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d",indexPath.row + 1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}



#pragma mark- scroll delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_pathCover scrollViewDidScroll:scrollView];
    
    //    NSLog(@"0=====Scroll-->%f",scrollView.contentOffset.y);
    
    CGFloat currentPostion = scrollView.contentOffset.y;
    
    NSLog(@"currentPostion - _lastPosition is %f",currentPostion - _lastPosition);
    
    NSLog(@"_lastPosition - currentPostion is %f",_lastPosition - currentPostion);
    
    if (currentPostion - _lastPosition > 15 )
    {
        //NSLog(@"ScrollUp now");
        _lastPosition = currentPostion;
        
        btnouter.hidden = true;
        
        
        
    }
    else if (_lastPosition - currentPostion > 15)
    {
        //NSLog(@"ScrollDown now");
        _lastPosition = currentPostion;
        
        btnouter.hidden = false;
        
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
}


@end
