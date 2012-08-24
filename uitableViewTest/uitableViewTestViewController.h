//
//  uitableViewTestViewController.h
//  uitableViewTest
//
//  Created by En on 12/8/24.
//  Copyright (c) 2012年 En. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface uitableViewTestViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIBarButtonItem *barBtn;
    IBOutlet UITableView *tableShow;
    NSMutableArray *array;
}

@end
