//
//  fontVC.m
//  chanhui
//
//  Created by 名侯 on 17/1/22.
//  Copyright © 2017年 侯彦名. All rights reserved.
//

#import "fontVC.h"

@interface fontVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSArray *familyNames;
@property (nonatomic ,strong) UILabel *titleLB;
@property (nonatomic ,strong) UILabel *detaileLB;

@end

@implementation fontVC

- (void)viewDidLoad {
    self.title = @"字体";
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    
    UITableView *mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, ScreenHeight-214) style:UITableViewStylePlain];
    mainTV.delegate = self;
    mainTV.dataSource = self;
    [self.view addSubview:mainTV];
    
    _familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    imageV.image = [UIImage imageNamed:@"ziti_lufei"];
    [self.view addSubview:imageV];
    
    _titleLB = [UILabel new];
    _titleLB.text = @"海贼王－2017\nONE PIECE";
    _titleLB.textColor = textTitle;
    _titleLB.numberOfLines = 0;
    [self.view addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.left.mas_equalTo(self.view).offset(20);
    }];
    
    
    _detaileLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, ScreenWidth-40, 20)];
    _detaileLB.textAlignment = NSTextAlignmentRight;
    _detaileLB.textColor = textSubtitle;
    _detaileLB.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_detaileLB];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.familyNames.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _titleLB.font = [UIFont fontWithName:self.familyNames[indexPath.row] size:16];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.familyNames[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:self.familyNames[indexPath.row] size:14];
   
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.detailTextLabel.font = [UIFont fontWithName:[UIFont familyNames][5] size:13];
    
    return cell;
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

@end
