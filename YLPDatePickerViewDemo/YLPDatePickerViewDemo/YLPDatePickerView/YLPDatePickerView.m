//
//  YLPDatePickerView.m
//  YLPDatePickerView
//
//  Created by YangLiPing on 2022/2/27.
//

#import "YLPDatePickerView.h"



@interface YLPDatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

//左边按钮
@property(nonatomic,strong)UIButton *leftBtn;
//右边按钮
@property(nonatomic,strong)UIButton *rightBtn;
//中间标题
@property(nonatomic,strong)UILabel *titleLabel;


//uiPickerView
@property(nonatomic,strong)UIPickerView *pickerView;

//=============数据
//返回的选择日期数据
@property(nonatomic,strong)YLPDatePickerView_DataModel *dataModel;


//记录列表对应的日期类型
@property(nonatomic,strong)NSArray *dateTypeForComponentsArr;




//--------------日期数组数据
@property(nonatomic,strong)NSArray *yearDataArr;
@property(nonatomic,strong)NSArray *monthDataArr;
@property(nonatomic,strong)NSArray *dayDataArr;
@property(nonatomic,strong)NSArray *hourDataArr;
@property(nonatomic,strong)NSArray *minuteDataArr;
@property(nonatomic,strong)NSArray *secondsDataArr;
//选中的下标
@property(nonatomic,assign)NSInteger yearSelectIndex;
@property(nonatomic,assign)NSInteger monthSelectIndex;
@property(nonatomic,assign)NSInteger daySelectIndex;
@property(nonatomic,assign)NSInteger hourSelectIndex;
@property(nonatomic,assign)NSInteger minuteSelectIndex;
@property(nonatomic,assign)NSInteger secondsSelectIndex;



@end

@implementation YLPDatePickerView


-(instancetype)initWithFrame:(CGRect)frame  WithTitleStr:(NSString *)titleStr AndLeftBtnStr:(NSString *)leftBtnStr AndRightBtnTitle:(NSString *)rightBtnStr{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        [self UI_configureView];
        
        
        //就三个数据 放到这里赋值
        self.titleLabel.text=[NSString stringWithFormat:@"%@",titleStr];
        [self.leftBtn setTitle:[NSString stringWithFormat:@"%@",leftBtnStr] forState:(UIControlStateNormal)];
        [self.rightBtn setTitle:[NSString stringWithFormat:@"%@",rightBtnStr] forState:(UIControlStateNormal)];
    }
    return self;
}


#pragma mark - UI搭建
-(void)UI_configureView{
    
    CGFloat bgViewWidth=self.frame.size.width;
    CGFloat bgViewHeight=self.frame.size.height;
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, bgViewWidth, bgViewHeight)];
    [self addSubview:bgView];
    bgView.backgroundColor=[UIColor colorWithDisplayP3Red:243 green:243 blue:243 alpha:1];
    bgView.layer.masksToBounds=YES;
    bgView.layer.cornerRadius=5.0;
    
    
    //标题
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake((bgViewWidth-200)/2, 0, 200, 40)];
    [bgView addSubview:self.titleLabel];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.font=[UIFont systemFontOfSize:16.0];
    self.titleLabel.textColor=[UIColor blackColor];
    self.titleLabel.text=@"";
    
    
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, 100, 40)];
    [bgView addSubview:self.leftBtn];
    [self.leftBtn setTitle:@"" forState:(UIControlStateNormal)];
    [self.leftBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    self.leftBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [self.leftBtn addTarget:self action:@selector(Action_leftBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(bgViewWidth-100, 0, 80, 40)];
    [bgView addSubview:self.rightBtn];
    [self.rightBtn setTitle:@"" forState:(UIControlStateNormal)];
    [self.rightBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    self.rightBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.rightBtn addTarget:self action:@selector(Action_rightBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    //================pickerView
    self.pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, bgViewWidth, bgViewHeight-40)];
    [bgView addSubview:self.pickerView];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    
    
}


#pragma mark - 按钮事件
//左边按钮
-(void)Action_leftBtn{
    
    [self removeFromSuperview];
    //得到结果数据
    [self Even_getResultDataModel];
    if (self.selectBlock) {
        self.selectBlock(YLPDatePickerViewSelectBlockType_LeftBtnSelected, self.dataModel);
    }
}

//右边按钮
-(void)Action_rightBtn{
    
    [self removeFromSuperview];
    //得到结果数据
    [self Even_getResultDataModel];
    if (self.selectBlock) {
        self.selectBlock(YLPDatePickerViewSelectBlockType_RightBtnSelected, self.dataModel);
    }
}



#pragma mark - PickerView 代理
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return [self.dateTypeForComponentsArr count];
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    //当前列的日期类型
    NSInteger currentType=[self.dateTypeForComponentsArr[component] integerValue];
    //判断类型
    if ((currentType&YLPDatePickerViewType_Year)==currentType) {
        return [self.yearDataArr count];
    }
    if ((currentType&YLPDatePickerViewType_Month)==currentType) {
        return [self.monthDataArr count];
    }
    
    if ((currentType&YLPDatePickerViewType_Day)==currentType) {
        NSInteger daysCount=[self.dayDataArr count];
        if (self.isAutoDaysInMonth&&[self.dateTypeForComponentsArr containsObject:@(YLPDatePickerViewType_Year)]&&[self.dateTypeForComponentsArr containsObject:@(YLPDatePickerViewType_Month)]) {//随选择年月调整天数,必须包含年月
            [self Even_getResultDataModel];
            daysCount=[self Even_getYearMonthHasDaysNumWithYearStr:self.dataModel.yearStr andMonthStr:self.dataModel.monthStr];
        }
        return daysCount;
    }
    
    if ((currentType&YLPDatePickerViewType_Hour)==currentType) {
        return [self.hourDataArr count];
    }
    if ((currentType&YLPDatePickerViewType_Minute)==currentType) {
        return [self.minuteDataArr count];
    }
    if ((currentType&YLPDatePickerViewType_Seconds)==currentType) {
        return [self.secondsDataArr count];
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    //当前列的日期类型
    NSInteger currentType=[self.dateTypeForComponentsArr[component] integerValue];
    //判断类型
    if ((currentType&YLPDatePickerViewType_Year)==currentType) {
        return [NSString stringWithFormat:@"%@",self.yearDataArr[row]];
    }
    if ((currentType&YLPDatePickerViewType_Month)==currentType) {
        return [NSString stringWithFormat:@"%@",self.monthDataArr[row]];
    }
    if ((currentType&YLPDatePickerViewType_Day)==currentType) {
        return [NSString stringWithFormat:@"%@",self.dayDataArr[row]];
    }
    if ((currentType&YLPDatePickerViewType_Hour)==currentType) {
        return [NSString stringWithFormat:@"%@",self.hourDataArr[row]];
    }
    if ((currentType&YLPDatePickerViewType_Minute)==currentType) {
        return [NSString stringWithFormat:@"%@",self.minuteDataArr[row]];
    }
    if ((currentType&YLPDatePickerViewType_Seconds)==currentType) {
        return [NSString stringWithFormat:@"%@",self.secondsDataArr[row]];
    }
    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //当前列的日期类型
    NSInteger currentType=[self.dateTypeForComponentsArr[component] integerValue];
    //判断类型
    if ((currentType&YLPDatePickerViewType_Year)==currentType) {
        self.yearSelectIndex=row;
    }
    if ((currentType&YLPDatePickerViewType_Month)==currentType) {
        self.monthSelectIndex=row;
    }
    if ((currentType&YLPDatePickerViewType_Day)==currentType) {
        self.daySelectIndex=row;
    }
    if ((currentType&YLPDatePickerViewType_Hour)==currentType) {
        self.hourSelectIndex=row;
    }
    if ((currentType&YLPDatePickerViewType_Minute)==currentType) {
        self.minuteSelectIndex=row;
    }
    if ((currentType&YLPDatePickerViewType_Seconds)==currentType) {
        self.secondsSelectIndex=row;
    }
    
    //刷新天数列表
    if (currentType!=YLPDatePickerViewType_Day&&self.isAutoDaysInMonth){
        //年月份改变年份
        [self.pickerView reloadAllComponents];
    }

    //得到结果数据
    [self Even_getResultDataModel];
    if (self.selectBlock) {
        self.selectBlock(YLPDatePickerViewSelectBlockType_CellSelected, self.dataModel);
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    CGFloat bgViewWidth=self.frame.size.width;
    //当前列的日期类型
    NSInteger currentType=[self.dateTypeForComponentsArr[component] integerValue];
    if ([self.dateTypeForComponentsArr containsObject:@(YLPDatePickerViewType_Year)]) {
        NSInteger count=[self.dateTypeForComponentsArr count]+1;
        if ((currentType&YLPDatePickerViewType_Year)==currentType) {
            return bgViewWidth/count*2;
        }else{
            return bgViewWidth/count;
        }
        
    }else{
        return bgViewWidth/[self.dateTypeForComponentsArr count];
    }
}


-(void)Even_getResultDataModel{
    self.dataModel=nil;//清空数据
    
    for (int i=0; i<6; i++) {
        NSInteger type=1<<i;
        if ((self.dateType&type)==type) {
            switch (type) {
                case YLPDatePickerViewType_Year:
                {
                    self.dataModel.yearStr=[NSString stringWithFormat:@"%@",self.yearDataArr[self.yearSelectIndex?:0]];
                }
                    break;
                case YLPDatePickerViewType_Month:
                {
                    self.dataModel.monthStr=[NSString stringWithFormat:@"%@",self.monthDataArr[self.monthSelectIndex?:0]];
                }
                    break;
                case YLPDatePickerViewType_Day:
                {
                    self.dataModel.dayStr=[NSString stringWithFormat:@"%@",self.dayDataArr[self.daySelectIndex?:0]];
                }
                    break;
                case YLPDatePickerViewType_Hour:
                {
                    self.dataModel.hourStr=[NSString stringWithFormat:@"%@",self.hourDataArr[self.hourSelectIndex?:0]];
                }
                    break;
                case YLPDatePickerViewType_Minute:
                {
                    self.dataModel.minuteStr=[NSString stringWithFormat:@"%@",self.minuteDataArr[self.minuteSelectIndex?:0]];
                }
                    break;
                case YLPDatePickerViewType_Seconds:
                {
                    self.dataModel.secondStr=[NSString stringWithFormat:@"%@",self.monthDataArr[self.secondsSelectIndex?:0]];
                }
                    break;
                default:
                    break;
            }
        }
    }

}


#pragma mark - Set方法
-(void)setDateType:(YLPDatePickerViewType)dateType{
    _dateType=dateType;
    
    NSMutableArray *dateTypeForComponentsArrM=[[NSMutableArray alloc]init];
    //计算出列表数量和列数对应的日期类型
    for (int i=0; i<6; i++) {
        NSInteger type=1<<i;
        if ((self.dateType&type)==type) {
            //按顺序记录日期类型
            [dateTypeForComponentsArrM addObject:@(type)];
        }
    }
    
    //将处理好的数据赋值
    self.dateTypeForComponentsArr=[dateTypeForComponentsArrM mutableCopy];
}

-(void)RefreshUI{
    [self.pickerView reloadAllComponents];
    
    
    //清空数据
    self.dataModel=nil;
}


#pragma mark - 懒加载
-(NSArray *)yearDataArr{
    if(!_yearDataArr){
        int currentYear=[[self Even_getCurrentTimeWithFormat:@"yyyy"] intValue];
        NSMutableArray *yearDataArrM=[NSMutableArray array];
        for (int i=currentYear; i>=1972; i--) {
            [yearDataArrM addObject:[NSString stringWithFormat:@"%d",i]];
        }
        _yearDataArr=[yearDataArrM mutableCopy];
    }
    return _yearDataArr;
}


-(NSArray *)monthDataArr{
    if (!_monthDataArr) {
        _monthDataArr=[self Even_getDataArrWithStartNum:1 AndEndNum:12];
    }
    return _monthDataArr;
}

-(NSArray *)dayDataArr{
    if (!_dayDataArr) {
        _dayDataArr=[self Even_getDataArrWithStartNum:1 AndEndNum:31];
    }
    return _dayDataArr;
}

-(NSArray *)hourDataArr{
    if (!_hourDataArr) {
        _hourDataArr=[self Even_getDataArrWithStartNum:0 AndEndNum:23];
    }
    
    return _hourDataArr;
}

-(NSArray *)minuteDataArr{
    if (!_minuteDataArr) {
        _minuteDataArr=[self Even_getDataArrWithStartNum:0 AndEndNum:59];
    }
    return _minuteDataArr;
}

-(NSArray *)secondsDataArr{
    if (!_secondsDataArr) {
        _secondsDataArr=[self Even_getDataArrWithStartNum:0 AndEndNum:59];
    }
    return _secondsDataArr;
}

-(YLPDatePickerView_DataModel *)dataModel{
    if (!_dataModel) {
        _dataModel=[YLPDatePickerView_DataModel new];
    }
    return _dataModel;
}


//循环数据
-(NSArray *)Even_getDataArrWithStartNum:(int)startNum AndEndNum:(int)endNum{
    NSMutableArray *dataArrM=[[NSMutableArray alloc]init];
    
    for (int i=startNum; i<=endNum; i++) {
        [dataArrM addObject:[NSString stringWithFormat:@"%d",i]];
    }
    return [dataArrM mutableCopy];
}



#pragma mark -  时间方法
//获取当前日期格式
-(NSString *)Even_getCurrentTimeWithFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString * currentTimeStr = [formatter stringFromDate:[NSDate date]];
    
    return currentTimeStr;
}


//获取年月的总天数
-(NSInteger)Even_getYearMonthHasDaysNumWithYearStr:(NSString *)yearStr andMonthStr:(NSString *)monthStr{
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@",yearStr,monthStr];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM";
    NSDate *date = [format dateFromString:dateStr];
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSInteger dayCountOfThisMonth = daysInLastMonth.length;
    return dayCountOfThisMonth;
}


@end


