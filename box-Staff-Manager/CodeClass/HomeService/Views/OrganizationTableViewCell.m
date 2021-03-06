//
//  OrganizationTableViewCell.m
//  box-Staff-Manager
//
//  Created by Yu Huang on 2018/3/28.
//  Copyright © 2018年 2se. All rights reserved.
//

#import "OrganizationTableViewCell.h"

@interface OrganizationTableViewCell()

@property (nonatomic,strong) UILabel *nameTitleLab;

@property (nonatomic,strong) UIView *lineView;

@end

@implementation OrganizationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    [self createView];
    return self;
}

-(void)createView
{
    _nameTitleLab = [[UILabel alloc]init];
    _nameTitleLab.font = Font(15);
    _nameTitleLab.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.contentView addSubview:_nameTitleLab];
    [_nameTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(0);
    }];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor colorWithHexString:@"#e8e8e8"];
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.offset(1);
    }];
}

- (void)setDataWithModel:(SearchMenberModel *)model
{
    if (model.employee_num > 0) {
        _nameTitleLab.text = [NSString stringWithFormat:@"%@ (%ld)", model.account, model.employee_num];
    }else{
        _nameTitleLab.text = model.account;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
