//
//  ViewController.m
//  YLPDatePickerViewDemo
//
//  Created by YangLiPing on 2022/2/27.
//

#import "ViewController.h"



#import "YLPDatePickerView.h"

@interface ViewController ()

@property(nonatomic,strong)YLPDatePickerView *pickerView;


//日期类型选择按钮数组
@property(nonatomic,strong)NSMutableArray *btnDataArrM;
//选中传入日期类型
@property(nonatomic,assign)YLPDatePickerViewType dateType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"日期选择页面";
    
    [self UI_configureVC];
    
}

#pragma mark - UI搭建
-(void)UI_configureVC{
    
    
    CGFloat bgViewWidth=self.view.frame.size.width;
    CGFloat bgViewHeigh=self.view.frame.size.height;
    //==================
   
    self.btnDataArrM=[NSMutableArray new];
    NSArray *btnTitleArr=@[@"年",@"月",@"日",@"时",@"分",@"秒"];
    for (int i=0; i<6; i++) {
        UIButton *Btn=[[UIButton alloc]initWithFrame:CGRectMake((bgViewWidth/4-80)/2, 40*i+40, 80, 30)];
        [self.view addSubview:Btn];
        [Btn setTitle:btnTitleArr[i] forState:(UIControlStateNormal)];
        [Btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [Btn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        Btn.backgroundColor=[UIColor lightGrayColor];
        Btn.layer.masksToBounds=YES;
        Btn.layer.cornerRadius=5.0;
        [Btn addTarget:self action:@selector(Action_dateTypeBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.btnDataArrM addObject:Btn];
    }
    
    
    UIButton *submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(200, 60, 80, 60)];
    [self.view addSubview:submitBtn];
    [submitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    submitBtn.layer.masksToBounds=YES;
    submitBtn.layer.cornerRadius=5.0;
    submitBtn.backgroundColor=[UIColor orangeColor];
    [submitBtn addTarget:self action:@selector(Action_submitBtn) forControlEvents:(UIControlEventTouchUpInside)];
    
    


    self.pickerView=[[YLPDatePickerView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 200) WithTitleStr:@"日期选择器" AndLeftBtnStr:@"取消" AndRightBtnTitle:@"确定"];
    [self.view addSubview:self.pickerView];
    self.pickerView.isAutoDaysInMonth=YES;
    self.pickerView.selectBlock = ^(YLPDatePickerViewSelectBlockType blockType, YLPDatePickerView_DataModel *dataModel) {
//        switch (blockType) {
//            case YLPDatePickerViewSelectBlockType_CellSelected:
//            {
                NSLog(@"%@_%@_%@_%@_%@_%@",dataModel.yearStr,dataModel.monthStr,dataModel.dayStr,dataModel.hourStr,dataModel.minuteStr,dataModel.secondStr);
//            }
//                break;
//
//            default:
//                break;
//        }
    };
    
}


#pragma mark - 按钮事件
-(void)Action_dateTypeBtn:(UIButton *)sender{
    sender.selected=!sender.isSelected;
    
}


-(void)Action_submitBtn{
    
    YLPDatePickerViewType type=0;
    for (int i=0; i<6; i++) {
        UIButton *btn=self.btnDataArrM[i];
        
        if (btn.isSelected) {
            type=type|(1<<i);
        }
        
    }
    
    
    self.pickerView.dateType=type;
    [self.pickerView RefreshUI];
}

#pragma mark - 网络请求





@end
