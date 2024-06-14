//
//  YPPChatController.m
//  YPPKoa
//
//  Created by DZ0400843 on 2022/5/9.
//  Copyright © 2022 leigaopan. All rights reserved.
//
#import <Masonry.h>
#import "YPPChatVM.h"
#import "YPPChatCell.h"
#import "YPPChatController.h"

@interface YPPChatController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tb;
@property (nonatomic, strong) UIButton *controlBtn;
@property (nonatomic, strong) YPPChatVM *vm;

@end

@implementation YPPChatController

- (instancetype)init {
    if (self = [super init]) {
        self.vm = [[YPPChatVM alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self bind];
}
#pragma mark - 逻辑
- (void)bind {
    @weakify(self)
    [self.vm.refreshSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.vm.cvms enumerateObjectsUsingBlock:^(YPPChatCellVM * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.tb registerClass:NSClassFromString(obj.cellCls) forCellReuseIdentifier:obj.cellCls];
        }];
        [self.tb reloadData];
        [self.tb scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.vm.cvms.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
}

- (void)sendText {
    NSDictionary *data = @{
        @"text":@"百日依山尽, 黄河入海流, 欲穷千里目, 更上一层楼",
        @"type":@(YPPChatMessageUITypeText)
    };
    [self.vm send:data];
}

- (void)sendPic {
    NSDictionary *data = @{
        @"pic":@"https://pica.zhimg.com/70/v2-6394b7c91f9a01419a59995e0a52b983_1440w.avis?source=172ae18b&biz_tag=Post",
        @"type":@(YPPChatMessageUITypePic)
    };
    [self.vm send:data];
}

- (void)recevieText {
    NSDictionary *data = @{
        @"text":@"窗前明月光, 疑是地上霜, 举头望明月, 低头思故乡",
        @"type":@(YPPChatMessageUITypeText)
    };
    YPPChatIMModel *imModel = [[YPPChatIMModel alloc] init];
    imModel.imType = YPPChatIMModelTypeChat;
    imModel.data = data;
    [self.vm receive:imModel];
}

- (void)receviePic {
    NSDictionary *data = @{
        @"pic":@"https://wx4.sinaimg.cn/mw2000/61a18504ly1h22d7razgfj20mw0ezmz1.jpg",
        @"type":@(YPPChatMessageUITypePic)
    };
    YPPChatIMModel *imModel = [[YPPChatIMModel alloc] init];
    imModel.imType = YPPChatIMModelTypeChat;
    imModel.data = data;
    [self.vm receive:imModel];
}

- (void)recevieUnknown {
    NSDictionary *data = @{
        @"pic":@"https://wx4.sinaimg.cn/mw2000/61a18504ly1h22d7razgfj20mw0ezmz1.jpg",
        @"type":@(YPPChatMessageUITypeVideo)
    };
    YPPChatIMModel *imModel = [[YPPChatIMModel alloc] init];
    imModel.imType = YPPChatIMModelTypeChat;
    imModel.data = data;
    [self.vm receive:imModel];
}

- (void)showSheet {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *a = [UIAlertAction actionWithTitle:@"发送图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendPic];
    }];
    UIAlertAction *b = [UIAlertAction actionWithTitle:@"发送文字" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendText];
    }];
    UIAlertAction *c = [UIAlertAction actionWithTitle:@"接收图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self receviePic];
    }];
    UIAlertAction *d = [UIAlertAction actionWithTitle:@"接收文字" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self recevieText];
    }];
    UIAlertAction *e = [UIAlertAction actionWithTitle:@"接收未知消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self recevieUnknown];
    }];
    UIAlertAction *z = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:a];
    [alert addAction:b];
    [alert addAction:c];
    [alert addAction:d];
    [alert addAction:e];
    [alert addAction:z];

    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.cvms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPPChatCellVM *cvm = self.vm.cvms[indexPath.row];
    YPPChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cvm.cellCls];
    [cell bind:cvm];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPPChatCellVM *cvm = self.vm.cvms[indexPath.row];
    return [cvm cellHeight];
}

#pragma mark - 准备工作
- (void)setupViews {
    [self.view addSubview:self.tb];
    [self.tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.controlBtn];
    [self.controlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tb.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(79);
    }];
}

- (UITableView *)tb {
    if (_tb) return _tb;
    _tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.showsVerticalScrollIndicator = NO;
    return _tb;
}

- (UIButton *)controlBtn {
    if (_controlBtn) return _controlBtn;
    _controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_controlBtn setTitle:@"动作" forState:UIControlStateNormal];
    [_controlBtn setTitleColor:UIColor.cyanColor forState:UIControlStateNormal];
    _controlBtn.backgroundColor = UIColor.grayColor;
    [_controlBtn addTarget:self action:@selector(showSheet) forControlEvents:UIControlEventTouchUpInside];
    return _controlBtn;
}

@end
