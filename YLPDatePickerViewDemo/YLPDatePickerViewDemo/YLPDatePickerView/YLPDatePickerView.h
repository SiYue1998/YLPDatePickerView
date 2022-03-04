//
//  YLPDatePickerView.h
//  YLPDatePickerView
//
//  Created by YangLiPing on 2022/2/27.
//

#import <UIKit/UIKit.h>


#import "YLPDatePickerViewCommon.h"
#import "YLPDatePickerView_DataModel.h"



typedef void(^YLPDatePickerViewSelectBlock) (YLPDatePickerViewSelectBlockType blockType,YLPDatePickerView_DataModel *dataModel);


/**
 日期选择器
 */
@interface YLPDatePickerView : UIView


//初始化
-(instancetype)initWithFrame:(CGRect)frame WithTitleStr:(NSString *)titleStr AndLeftBtnStr:(NSString *)leftBtnStr AndRightBtnTitle:(NSString *)rightBtnStr;

//刷新UI
-(void)RefreshUI;


//是否自动调整天数 默认NO 必须年月日都有才根据选中年月调整天数，不包含年月日的话yes也不出现
@property(nonatomic,assign)bool isAutoDaysInMonth;

//选择的显示日期类型
@property(nonatomic,assign)YLPDatePickerViewType dateType;

//数据回调
@property(nonatomic,copy)YLPDatePickerViewSelectBlock selectBlock;


@end







