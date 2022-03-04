//
//  YLPDatePickerViewCommon.h
//  YLPDatePickerViewDemo
//
//  Created by YangLiPing on 2022/3/4.
//

#ifndef YLPDatePickerViewCommon_h
#define YLPDatePickerViewCommon_h


/**
 存放一些类型，数据
 */


//--------------------------------类型
/**
 返回数据的事件响应类型
 */
typedef NS_ENUM(NSInteger,YLPDatePickerViewSelectBlockType) {
    YLPDatePickerViewSelectBlockType_CellSelected=1,//cell选中
    YLPDatePickerViewSelectBlockType_LeftBtnSelected,//左边按钮选中
    YLPDatePickerViewSelectBlockType_RightBtnSelected//右边按钮选中
};


/**
 日期选择显示的日期类型，年月日时分秒
 */
typedef NS_ENUM(NSInteger,YLPDatePickerViewType) {
    YLPDatePickerViewType_Year      =1<<0,//年   0001 1
    YLPDatePickerViewType_Month     =1<<1,//月   0010 2
    YLPDatePickerViewType_Day       =1<<2,//日   0100 4
    YLPDatePickerViewType_Hour      =1<<3,//时   1000 8
    YLPDatePickerViewType_Minute    =1<<4,//分   1 0000  16
    YLPDatePickerViewType_Seconds   =1<<5,//秒   10 0000 32
};



#endif /* YLPDatePickerViewCommon_h */
