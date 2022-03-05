# YLPDatePickerView
日期选择工具，选择进位枚举传入可复选的类型
可以混搭年，月，日，时，分，秒中任意一种，或者多种。
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

//传入类型，传入重复也只会显示一个
self.pickerView.dateType=YLPDatePickerViewType_Year|YLPDatePickerViewType_Month|YLPDatePickerViewType_Day|YLPDatePickerViewType_Hour|YLPDatePickerViewType_Minute|YLPDatePickerViewType_Seconds;


//=============================================
数据通过cell选择和左右边按钮点击事件返回。
/**
 返回数据的事件响应类型
 */
typedef NS_ENUM(NSInteger,YLPDatePickerViewSelectBlockType) {
    YLPDatePickerViewSelectBlockType_CellSelected=1,//cell选中
    YLPDatePickerViewSelectBlockType_LeftBtnSelected,//左边按钮选中
    YLPDatePickerViewSelectBlockType_RightBtnSelected//右边按钮选中
};


//数据回调
self.pickerView.selectBlock = ^(YLPDatePickerViewSelectBlockType blockType, YLPDatePickerView_DataModel *dataModel) {
    switch (blockType) {
        case YLPDatePickerViewSelectBlockType_CellSelected:
        {
            
        }
            break;
        case YLPDatePickerViewSelectBlockType_LeftBtnSelected:
        {
           
        }
            break;
        case YLPDatePickerViewSelectBlockType_RightBtnSelected:
        {
            
        }
            break;
        default:
            break;
    }
};
