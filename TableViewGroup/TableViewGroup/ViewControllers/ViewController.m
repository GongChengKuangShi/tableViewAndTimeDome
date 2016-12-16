//
//  ViewController.m
//  TableViewGroup
//
//  Created by mgjr on 16/12/15.
//  Copyright © 2016年 mgjr. All rights reserved.
//

#import "ViewController.h"
#import "BaseTableView.h"
#import "BillHeadView.h"
#import "BillTableHeadView.h"
#import "BillEmptyCell.h"
#import "BillTableViewCell.h"


@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) BaseTableView *tableView;
@property (strong, nonatomic) BillTableHeadView *billTableHeadView;
@property (strong, nonatomic) NSMutableArray *tableViewData;
@property (nonatomic, strong) NSDictionary *actionMapDictionary;
@property (nonatomic, strong) NSMutableArray *tempDateSet;
@end

static NSString *billTableViewCell = @"BillTableViewCellID";
static NSString *billEmptyCell = @"BillEmptyCellID";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableViewUI];
    [self setTableViewData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark setNSMutableArray
- (NSMutableArray *)tableViewData {
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc] init];
    }
    return _tableViewData;
}

- (NSMutableArray *)tempDateSet {
    if (!_tempDateSet) {
        _tempDateSet = [[NSMutableArray alloc] init];
    }
    return _tempDateSet;
}

#pragma mark setDictionary 
- (NSDictionary *)actionMapDictionary {
    if (!_actionMapDictionary) {
        _actionMapDictionary = [[NSDictionary alloc] init];
    }
    return _actionMapDictionary;
}

#pragma mark setTableView 
- (void)setTableViewUI {
    self.tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.billTableHeadView = [[[NSBundle mainBundle] loadNibNamed:@"BillTableHeadView" owner:self options:nil] firstObject];
    self.billTableHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
    self.tableView.tableHeaderView = self.billTableHeadView;
    [self.tableView registerNib:[UINib nibWithNibName:@"BillTableViewCell" bundle:nil] forCellReuseIdentifier:billTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"BillEmptyCell" bundle:nil] forCellReuseIdentifier:billEmptyCell];
}

#pragma mark setData 
- (void)setTableViewData {
    NSString *urlString = @"https://app.hnmgjr.com/mgjr-web-app/V2.0/appAccount/billDetails?keyStr=75d655f225f9c2c80c57492c501f894f&mid=202045&pageNum=1&pageSize=30";
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    [self loadTableViewDataWithDictionary:dictionary];

}

#pragma mark loadData 
- (void)loadTableViewDataWithDictionary:(NSDictionary *)data {
    NSString *leftString = [NSString stringWithFormat:@"%@",[data safeObjectForKey:@"acountBalance"]];
    NSString *rightString = [data safeObjectForKey:@"withdrawingAmount"];
    _billTableHeadView.leftLabel.text = [leftString stringFormatterCurrencyStyle];
    _billTableHeadView.rightLabel.text = [rightString stringFormatterCurrencyStyle];
    if ([data checkObjectExit:@"actionMap"]) {
        NSDictionary *mapDictionary = [data objectForKey:@"actionMap"];
        self.actionMapDictionary = mapDictionary;
    }
    if ([data checkObjectExit:@"billDetailList"]) {
        NSArray * billDetailList = [data objectForKey:@"billDetailList"];
        [self setDataWithArray:billDetailList];
    }
    [self.tableView reloadData];
}



#pragma mark - UITableViewDelegate && TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.tempDateSet.count == 0) {
        return 1;
    } else {
        return self.tempDateSet.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    if (self.tableViewData.count != 0) {
        NSDictionary *sectionDictionary = [self.tableViewData objectAtIndex:section];
        if ([[sectionDictionary allValues] count] > 0) {
            return [[[sectionDictionary allValues] firstObject] count];
        }
    } else {
        return 1;
    }
    return 0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tempDateSet.count != 0) {
        return 57;
    } else {
        return SCREEN_HEIGHT - 90;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tableViewData.count == 0) {
        BillEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:billEmptyCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BillEmptyCell" owner:self options:nil] firstObject];
        }
        return cell;
    } else {
        BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:billTableViewCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BillTableViewCell" owner:self options:nil] firstObject];
        }
        NSDictionary *dictionary = [self.tableViewData objectAtIndex:indexPath.section];
        if ([[dictionary allValues] count] >0) {
            NSArray *array = [[dictionary allValues] firstObject];
         NSDictionary  *cellDictionary = (NSDictionary *)[array objectAtIndex:indexPath.row];
            [cell setDate:cellDictionary source:DataFromBillDetail];
            [self setcellTypeWithArray:array indexPath:indexPath cell:cell];
        }
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BillHeadView *headView = [[BillHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    NSString *string = self.tempDateSet[section];
    headView.label.text = [NSDate stringForDisplayFromInterval:[string doubleValue] / 1000 unitDay:0];
    return [self.tableView customTablevHeaderView:headView section:section style:TableViewsHeadCustom];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

#pragma mark 处理数据方法
- (void)setDataWithArray:(NSArray *)array {
    for (int i = 0; i < array.count; i++) {
        NSDictionary *item = [array objectAtIndex:i];
        NSString *ctimeString = [NSString stringWithFormat:@"%@",[item safeObjectForKey:@"ctime"]];
//        NSString *timeString = [ctimeString timeWithTimeIntervalStringToDay];
        if (![self.tempDateSet containsObject:ctimeString]) {
            [self.tempDateSet addObject:ctimeString];
            NSMutableArray *tempList = [[NSMutableArray alloc] init];
            [tempList addObject:item];
            NSDictionary *tempDictionary = [NSDictionary dictionaryWithObject:tempList forKey:ctimeString];
            [self.tableViewData addObject:tempDictionary];
        } else {
            for (int i = 0; i < self.tableViewData.count; i++) {
                NSMutableDictionary *tempDic = (NSMutableDictionary*)[self.tableViewData objectAtIndex:i];
                if ([[[tempDic allKeys] firstObject] isEqualToString:ctimeString]) {
                    NSMutableArray *tempDayList = [tempDic objectForKey:ctimeString];
                    [tempDayList addObject:item];
                }
            }
        }
    }
}

#pragma mark 处理cell的类型 
- (void)setcellTypeWithArray:(NSArray *)array  indexPath:(NSIndexPath *)indexPath cell:(BillTableViewCell *)cell {
    NSDictionary *transaction = array[indexPath.row];
    NSString *ctime = [[transaction safeObjectForKey:@"time"] timeWithTimeIntervalStringToDay];
    if (indexPath.row == 0) {
        cell.cellType = BillListFirst;
    } else {
        NSDictionary *lastDic = array[indexPath.row - 1];
        NSString *lastTime = [[lastDic safeObjectForKey:@"time"] timeWithTimeIntervalStringToDay];
        if ([ctime isEqualToString:lastTime]) {
            if (![transaction isEqual:[array lastObject]]) {
                cell.dateLabel.text = @"";
                cell.cellType = BillListNotTime;
            }
        }
    }
    if ([transaction isEqual:[array firstObject]]) {
        cell.cellType = BillListFirst;
    }
    if ( [transaction isEqual:[array lastObject]]) {
        cell.cellType = BillListLast;
    }
    if (array.count == 1) {
        cell.cellType = BillListHideline;
    }
}

@end
