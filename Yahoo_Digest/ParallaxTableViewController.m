//
//  ParallaxTableViewController.m
//  Yahoo_Digest
//
//  Created by Vy Systems - iOS1 on 10/7/14.
//  Copyright (c) 2014 Vy Systems - iOS1. All rights reserved.
//

#import "ParallaxTableViewController.h"
#import "XHPathCover.h"
#import "HUAJIENewsCell.h"

#define anim_time 0.5
@interface ParallaxTableViewController ()

@property (nonatomic, strong) XHPathCover *pathCover;

//@property (weak, nonatomic) IBOutlet XHPathCover *pathCover;

@end


UIButton *btnouter;
BOOL hidden;
BOOL isAnimating;
CGFloat _lastPosition;
@implementation ParallaxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 250)];
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"MenuBackground"]];
    //[_pathCover setAvatarImage:[UIImage imageNamed:@"meicon.png"]];
   // [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack xhzengAIB", XHUserNameKey, @"1990-10-19", XHBirthdayKey, nil]];
    _pathCover.isZoomingEffect = YES;
    self.tableView.tableHeaderView = self.pathCover;
    
    __weak ParallaxTableViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    [_pathCover setHandleTapBackgroundImageEvent:^{
        [wself.pathCover setBackgroundImage:[UIImage imageNamed:@"AlbumHeaderBackgrounImage"]];
    }];

    /*
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"MenuBackground"]];
    //[_pathCover setAvatarImage:[UIImage imageNamed:@"meicon.png"]];
    //[_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack xhzengAIB", XHUserNameKey, @"1990-10-19", XHBirthdayKey, nil]];
    _pathCover.isZoomingEffect = YES;
    self.tableView.tableHeaderView = self.pathCover;
    
    __weak ParallaxTableViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    [_pathCover setHandleTapBackgroundImageEvent:^{
        [wself.pathCover setBackgroundImage:[UIImage imageNamed:@"AlbumHeaderBackgrounImage"]];
    }];
*/
    
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
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * VC = [storyBoard instantiateViewControllerWithIdentifier:@"TestViewController"];
    
    
    [self.navigationController pushViewController:VC animated:YES];
   // [self presentViewController:VC animated:YES completion:nil];
}


- (void)_refreshing
{
    // refresh your data sources
    
    __weak ParallaxTableViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wself.pathCover stopRefresh];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    else if (_lastPosition - currentPostion > 15)
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
