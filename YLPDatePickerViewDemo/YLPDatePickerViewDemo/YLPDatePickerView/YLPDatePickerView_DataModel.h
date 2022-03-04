//
//  YLPDatePickerView_DataModel.h
//  YLPDatePickerViewDemo
//
//  Created by YangLiPing on 2022/3/4.
//

#import <Foundation/Foundation.h>


/**
 数据模型   用于返回日期数据
 */
@interface YLPDatePickerView_DataModel : NSObject

//年
@property(nonatomic,copy)NSString *yearStr;
//月
@property(nonatomic,copy)NSString *monthStr;
//日
@property(nonatomic,copy)NSString *dayStr;
//时
@property(nonatomic,copy)NSString *hourStr;
//分
@property(nonatomic,copy)NSString *minuteStr;
//秒
@property(nonatomic,copy)NSString *secondStr;


@end
