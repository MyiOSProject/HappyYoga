//
//  HYMessageTableViewController.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/10.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYMessageTableViewController.h"
#import "HYMessageListTableViewCell.h"
//#import "YKTMessageDialog.h"
#import "HYMessageDBManager.h"
#import "HYNetHeader.h"
//#import "YKTMessageNew.h"
#import "HYPullingTableViewModel.h"

@interface HYMessageTableViewController ()
{
    NSMutableArray *_dataMessage;
    NSDictionary *_selectedItem;
    NSInteger _pageIndex;
    NSInteger _totalPage;
    HYMessageDBManager *_dbm;
    HYGlobalParams *_gParams;
    HYPullingTableViewModel *_pullModel;
    
    UISearchBar *_searchBar;
    NSString *_keyword;
}
@end

@implementation HYMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"msg_new.png"] style:UIBarButtonItemStylePlain target:self action:@selector(writeMsg:)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self initSearchBar];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    _dbm = [[HYMessageDBManager alloc] init];
    _gParams = [HYGlobalParams sharedInstance];
    _dataMessage = [[NSMutableArray alloc] initWithCapacity:10];
    
    [self initData];
    
    
    _pullModel = [[HYPullingTableViewModel alloc] init];
    _pullModel.delegate = self;
    
    _pageIndex = 1;
//    [self queryData];
}

- (void)initData {
    NSArray *data = [_dbm getMessageGrp:_gParams.mobile];
//    if (data && data.count > 0) {
    if(false){
        for (HYMessageModel *item in data) {
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:item.customerName, @"name", item.createTime,  @"createTime",[NSNumber numberWithBool:item.unread] , @"unread",[NSNumber numberWithInteger:item.customerId] , @"customerId", item.content, @"content",[NSNumber numberWithInteger:item.mid], @"mid", item.mobile, @"mobile",nil];
            [_dataMessage addObject:dic];
        }
    }else{
        NSDictionary *dic0 = [[NSDictionary alloc] initWithObjectsAndKeys:@"李思博",@"name", @"2016-09-29 15:00:32",  @"createTime",@"1" ,@"unread", @"0",@"unmaintain", @"明天晚上7点西单广场见，签约合同，不见不散,明天晚上7点西单广场见，签约合同，不见不散,明天晚上7点西单广场见，签约合同，不见不散",@"content",[NSNumber numberWithInteger:1], @"id",  _gParams.mobile, @"mobile",nil];
        [_dataMessage addObject:dic0];
        NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"185****8508",@"name", @"2016-09-28 12:00:32",  @"createTime",@"1", @"unread", @"1", @"unmaintain", @"明天晚上7点西单广场见，签约合同，不见不散",@"content", [NSNumber numberWithInteger:2], @"id",  _gParams.mobile, @"mobile",nil];
        [_dataMessage addObject:dic1];
        NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"链家地产安定门张总",@"name", @"2016-09-27 20:00:32",  @"createTime",@"0", @"unread", @"0", @"unmaintain", @"明天晚上7点西单广场见，签约合同，不见不散,明天晚上7点西单广场见，签约合同，不见不散",@"content", [NSNumber numberWithInteger:3], @"id",  _gParams.mobile, @"mobile",nil];
        [_dataMessage addObject:dic2];
        NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"185****8501",@"name", @"2016-09-19 11:00:32",  @"createTime", @"0", @"unread", @"1", @"unmaintain", @"明天晚上7点西单广场见，签约合同，不见不散",@"content", [NSNumber numberWithInteger:4], @"id",  _gParams.mobile, @"mobile",nil];
        [_dataMessage addObject:dic3];
        NSDictionary *dic4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"李先生",@"name", @"2016-09-17 08:00:32",  @"createTime",@"0", @"unread", @"0", @"unmaintain", @"明天晚上7点西单广场见，签约合同，不见不散",@"content",[NSNumber numberWithInteger:5], @"id",  _gParams.mobile, @"mobile",nil];
        [_dataMessage addObject:dic4];
        
        [_dbm clearAllMessageGrp];   // 清空缓存
        
        for (NSDictionary *item in _dataMessage) {
            [_dbm saveMessageGrp:item];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [_searchBar resignFirstResponder];
    if (self.navigationController.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
        
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark searchBar
-(void)initSearchBar
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _searchBar.placeholder = @"输入联系人姓名";
    self.tableView.tableHeaderView = _searchBar;
    _searchBar.delegate = self;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search:%@", searchBar.text);
    if ([HYUtility stringContainsEmoji:searchBar.text]) {
        [LCAlertView showWithTitle:nil message:@"暂不支持表情符号" buttonTitle:YKT_ALERT_BTN_OK];
        return;
    }
    [_searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
    _pageIndex = 1;
    NSString *key = [HYUtility getNonNullString:searchBar.text];
    _keyword = (key.length > 0) ? key : nil;
    [self queryData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)queryData {
    if (_gParams.netConnected) {//有网络情况
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
        [params setValue:[NSNumber numberWithInteger:_pageIndex] forKey:@"pageIndex"];
        [params setValue:[NSNumber numberWithInteger:PAGESIZE30] forKey:@"pageSize"];
        if (_keyword) {
            NSDictionary *keyDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword, @"keyword", nil];
            [params setObject:keyDic forKey:@"other"];
        }
        [[HYNetWorkUtility sharedInstance] postRequestWithUrl:API_MESSAGE_LIST paramaters:params successBlock:^(HYApiResult *ret, NSURLResponse *response) {
            [self dealResult:ret];
        } FailBlock:^(NSError *error) {
            NSLog(@"request fail.err:%@", error.description);
        }];
    }else{//无网络情况从本地缓存数据取
        if (_keyword) {
            [LCAlertView showWithTitle:nil message:@"没有网络信号" buttonTitle:YKT_ALERT_BTN_OK];
            return;
        }
        if (_pageIndex > 1) {
            [LCAlertView showWithTitle:nil message:@"没有网络信号" buttonTitle:YKT_ALERT_BTN_OK];
        }else{
            [_dataMessage removeAllObjects];
            NSArray *msgGrpArr = [_dbm getMessageGrp:_gParams.mobile];
            if (msgGrpArr && msgGrpArr.count > 0) {
                [self showDataFromLocal:msgGrpArr];
            }
        }
    }
    
}

- (void)showDataFromLocal:(NSArray *)data {
    for (HYMessageModel *item in data) {
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:item.customerName, @"customerName", item.createTime,  @"createTime",[NSNumber numberWithBool:item.unread] , @"unread",[NSNumber numberWithInteger:item.customerId] , @"customerId", item.content, @"content",[NSNumber numberWithInteger:item.mid], @"mid", item.mobile, @"mobile",nil];
        [_dataMessage addObject:dic];
    }
    _pullModel.bottomEnd = YES;
    [self.tableView reloadData];
}

- (void)loadMoreData {
    if (_pageIndex < _totalPage) {
        _pageIndex++;
        [self queryData];
    }
}

- (void)dealResult:(HYApiResult *)ret {
    if (ret.result == HY_API_RETURN_SUCCESS) {
        NSArray *msgGrpArr = (NSArray *)[ret.value objectForKey:@"obj"];
        if (_pageIndex == 1) {
            [_dataMessage removeAllObjects];
        }
        for (NSDictionary *msgGrp in msgGrpArr) {
            NSString *customerName = [msgGrp objectForKey:@"customerName"];
            if (!customerName || customerName.length == 0) {
                customerName = @"";
            }
            NSInteger mid = [[msgGrp objectForKey:@"id"] integerValue];
            NSInteger customerId = [[msgGrp objectForKey:@"customerId"] integerValue];
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:customerName, @"customerName", [msgGrp objectForKey:@"createTime"],  @"createTime", [msgGrp objectForKey:@"unread"] , @"unread",[NSNumber numberWithInteger:customerId], @"customerId", [msgGrp objectForKey:@"sms_content"], @"content",[NSNumber numberWithInteger:mid], @"mid", _gParams.mobile, @"mobile",nil];
            [_dataMessage addObject:dic];
        }
        _totalPage = [[ret.value objectForKey:@"pageCount"] integerValue];
        [self.tableView reloadData];
        _pullModel.isLoading = NO;
        _pullModel.isRefreshing = NO;
        _pullModel.bottomEnd = (_pageIndex == _totalPage);
        if (_pageIndex == 1 && !_keyword) {
            [self dealLocalData:_dataMessage];
        }
        _keyword = nil;
    }else{
        [LCAlertView showWithTitle:nil message:ret.message buttonTitle:@"确认"];
    }
}

- (void)dealLocalData:(NSArray *)msgArr {
    [_dbm clearAllMessageGrp];
    [_dbm saveMessageGroup:msgArr];
}
#pragma mark - write msg
- (void)writeMsg:(id)sender {
    [self performSegueWithIdentifier:@"segShowMsgNew" sender:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _dataMessage.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYMessageListTableViewCell *cell = (HYMessageListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    NSDictionary *item = [_dataMessage objectAtIndex:indexPath.row];
    NSInteger unmaintain = [[item objectForKey:@"customerId"] integerValue];
    if (unmaintain == 0) {
        cell.headPic.image = [UIImage imageNamed:@"msg_list_head2.png"];
    }else{
        cell.headPic.image = [UIImage imageNamed:@"msg_list_head1.png"];
    }
    cell.contact.text = [item objectForKey:@"customerName"];
    
    BOOL unread = [[item objectForKey:@"unread"] boolValue];
    cell.unread.hidden = (unread == 0) ? YES : NO;
    cell.content.text = [item objectForKey:@"content"];
    NSDate *dt = [HYUtility dateFrom:[item objectForKey:@"createTime"] withFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.time.text = [NSString stringWithFormat:@"%@ %@", [HYUtility getContactDay:dt], [HYUtility getContactTime:dt]];
    return cell;
}

#pragma mark pullable methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
    [_searchBar setShowsCancelButton:NO];
    [_pullModel tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pullModel tableViewDidEndDragging:scrollView];
}

- (void)pullingTableViewDidStartLoading {
    NSLog(@"load more");
    [self loadMoreData];
}

- (void)pullingTableViewDidStartRefreshing {
    NSLog(@"Refresh view...");
    _pageIndex = 1;
    [self queryData];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"segMsgShowDetail"]) {
//        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
//        YKTMessageDialog *vc = (YKTMessageDialog *)[segue destinationViewController];
//        vc.paramItem = [_dataMessage objectAtIndex:selectedIndexPath.row];
//    }else if ([segue.identifier isEqualToString:@"segShowMsgNew"]) {
//        YKTMessageNew *vc = (YKTMessageNew *)[segue destinationViewController];
//        vc.formType = kMessageFormNew;
//    }
}

@end
