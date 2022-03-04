# YLPDatePickerView
 日期选择工具
可以混搭年，月，日，时，分，秒中任意一种，或者多种。
数据通过cell选择和左右边按钮点击事件返回。


self.pickerView=[[YLPDatePickerView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 200) WithTitleStr:@"日期选择器" AndLeftBtnStr:@"取消" AndRightBtnTitle:@"确定"];
    [self.view addSubview:self.pickerView];
    self.pickerView.dateType=YLPDatePickerViewType_Year|YLPDatePickerViewType_Month|YLPDatePickerViewType_Day|YLPDatePickerViewType_Hour|YLPDatePickerViewType_Minute|YLPDatePickerViewType_Seconds;
    self.pickerView.isAutoDaysInMonth=YES;
    //刷新页面
    [self.pickerView RefreshUI];
    self.pickerView.selectBlock = ^(YLPDatePickerViewSelectBlockType blockType, YLPDatePickerView_DataModel *dataModel) {
        switch (blockType) {
            case YLPDatePickerViewSelectBlockType_CellSelected:
            {
                NSLog(@"%@_%@_%@_%@_%@_%@",dataModel.yearStr,dataModel.monthStr,dataModel.dayStr,dataModel.hourStr,dataModel.minuteStr,dataModel.secondStr);
            }
                break;
            case YLPDatePickerViewSelectBlockType_LeftBtnSelected:
            {
                NSLog(@"%@_%@_%@_%@_%@_%@",dataModel.yearStr,dataModel.monthStr,dataModel.dayStr,dataModel.hourStr,dataModel.minuteStr,dataModel.secondStr);
            }
                break;
            case YLPDatePickerViewSelectBlockType_RightBtnSelected:
            {
                NSLog(@"%@_%@_%@_%@_%@_%@",dataModel.yearStr,dataModel.monthStr,dataModel.dayStr,dataModel.hourStr,dataModel.minuteStr,dataModel.secondStr);
            }
                break;
            default:
                break;
        }
    };

