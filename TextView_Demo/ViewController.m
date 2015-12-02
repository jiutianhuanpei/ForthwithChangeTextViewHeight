//
//  ViewController.m
//  TextView_Demo
//
//  Created by 沈红榜 on 15/12/2.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    UITextView      *_textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 70, 200, 100)];
    [self.view addSubview:_textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kkkk) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)kkkk {
    CGFloat height = [self reckonTextViewHeight:_textView];
    CGRect rect = [self changeRect:_textView.frame height:height];
    _textView.frame = rect;
}

- (CGRect)changeRect:(CGRect)rect height:(CGFloat)height {
    rect.size.height = height;
    return rect;
}



- (CGFloat)reckonTextViewHeight:(UITextView *)textView {
    CGRect frame = textView.bounds;
    CGSize fudgeFactor = CGSizeMake(10.0, 16.0);
    
    frame.size.height -= fudgeFactor.height;
    frame.size.width -= fudgeFactor.width;
    
    NSMutableAttributedString* textToMeasure;
    if(textView.attributedText && textView.attributedText.length > 0){
        textToMeasure = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    } else{
        textToMeasure = [[NSMutableAttributedString alloc] initWithString:textView.text];
        [textToMeasure addAttribute:NSFontAttributeName value:textView.font range:NSMakeRange(0, textToMeasure.length)];
    }
    
    if ([textToMeasure.string hasSuffix:@"\n"]) {
        [textToMeasure appendAttributedString:[[NSAttributedString alloc] initWithString:@"-" attributes:@{NSFontAttributeName: textView.font}]];
    }
    
    CGRect size = [textToMeasure boundingRectWithSize:CGSizeMake(CGRectGetWidth(frame), MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                              context:nil];
    
    CGFloat newHeight = CGRectGetHeight(size) + fudgeFactor.height;
    
    return newHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
