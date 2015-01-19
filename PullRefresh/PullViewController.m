//
//  PullViewController.m
//  PullRefresh
//
//  Created by Skye on 15/1/18.
//  Copyright (c) 2015年 Skye. All rights reserved.
//

#import "PullViewController.h"
#import "MJRefresh.h"

@interface PullViewController ()

@property(nonatomic,weak) UITableView *wTableView;

@property(nonatomic,strong) NSMutableArray *array;

@end

@implementation PullViewController

-(NSMutableArray *)array
{
    if(!_array)
    {
        _array = [NSMutableArray array];
        for (int i = 0; i<15; i++) {
            [_array addObject:@(i)];
        }
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView addHeaderWithTarget:self action:@selector(updateTableView)];
    
    [self.tableView addFooterWithTarget:self action:@selector(moreRows) isAutoRefresh:YES];

}

-(void)moreRows
{
    NSLog(@"get More Rows");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (int i = 0; i<10; i++) {
            [self.array addObject:@(i)];
        }
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    });
}
-(void)updateTableView
{
    NSLog(@"Update rows");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView headerEndRefreshing];
    });
}


-(void)clearCellLine:(UITableView *)tableView
{
    UIView *view = [[UITableView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = view;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.array[indexPath.row]];
    return cell;
}

@end
