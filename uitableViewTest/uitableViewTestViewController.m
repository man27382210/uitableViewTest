//
//  uitableViewTestViewController.m
//  uitableViewTest
//
//  Created by En on 12/8/24.
//  Copyright (c) 2012年 En. All rights reserved.
//

#import "uitableViewTestViewController.h"

@interface uitableViewTestViewController ()

@end

@implementation uitableViewTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    tableShow.delegate = self;
    array = [[NSMutableArray alloc]initWithObjects:@"HOOO",@"PIIII", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier2 = @"Cell2";
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    if (cell2 == nil)
    {
        cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
    }
    cell2.textLabel.text = @"moreData";
    cell2.textLabel.textColor = [UIColor blueColor];
    if([array count] == 0)//設定欄位，最初進入是放在row = 0
    {
        return cell2;
    }
    else if ([array count] != 0)//再來就放在最後一個
    {
        if (indexPath.row == [array count])
        {
            return cell2;
        }
    }
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UIButton *btn;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn addTarget:self action:@selector(GO:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 4, 30, 30);
        [btn setTag:0];
        [cell.contentView addSubview:btn];
    }
    else
    {
        btn = (UIButton *)[cell.contentView viewWithTag:0];
    }
    cell.textLabel.text =[array objectAtIndex:indexPath.row];
    return cell;
    
}

-(void)GO:(id)sender
{
    NSLog(@"super:%@  supersuper:%@  supersupersuper:%@",[sender superview],[[sender superview]superview],[[[sender superview]superview]superview]);
    for (UITableViewCell *cell in tableShow.subviews)
    {
        NSLog(@"Cell:%@",cell);
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"from:%d  to:%d",fromIndexPath.row,toIndexPath.row);
    if (fromIndexPath != toIndexPath && toIndexPath.row <  [array count])
    {
        id object = [array objectAtIndex:fromIndexPath.row];
        
        [array removeObjectAtIndex:fromIndexPath.row];
        if (toIndexPath.row > [array count])
        {
            [array addObject:object];
        }
        else
        {
            
            [array insertObject:object atIndex:toIndexPath.row];
        }
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    
    if (proposedDestinationIndexPath.row == [array count])
    {
        return sourceIndexPath;
    }
    else
    {
        return proposedDestinationIndexPath;
    }
    
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([array count] != 0)
    {
        if (indexPath.row != [array count] )//判斷是否為要moreData
        {
            return YES;
        }
        return NO;
    }
    else
        return NO;
}

-(IBAction)setToEditing
{
    if (tableShow.isEditing)
    {
        [tableShow setEditing:NO animated:NO];
        [barBtn setStyle:UIBarButtonItemStylePlain];
        [barBtn setTitle:@"Edit"];
    }
    else
    {
        [tableShow setEditing:YES animated:NO];
        [barBtn setStyle:UIBarButtonItemStyleDone];
        [barBtn setTitle:@"Done"];
    }
}

@end
