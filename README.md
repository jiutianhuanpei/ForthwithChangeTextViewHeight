# ForthwithChangeTextViewHeight
实时改变TextView的高度

![](https://github.com/jiutianhuanpei/ForthwithChangeTextViewHeight/raw/master/TextView_Demo/1.png)
```object
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
```
