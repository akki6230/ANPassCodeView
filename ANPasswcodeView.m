//
//  ANPasswcodeView.m
//  HoneyDew
//
//  Created by Ankit Kumar Yadav on 08/02/2017.
//  Copyright © 2017 Pravesh Dubey. All rights reserved.
//

#import "ANPasswcodeView.h"
#import "ANTextField.h"

@interface ANPasswcodeView()<UITextFieldDelegate, ANTextFiledDelegate>{

    NSInteger lengthOfCode;
    BOOL isDeleting;
    BOOL isAwakeFromNib;
}

#if TARGET_INTERFACE_BUILDER
@property(nonatomic) IBInspectable NSInteger length;
#else
@property(nonatomic) IBInspectable NSInteger length;
#endif

@end
@implementation ANPasswcodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"%@", self);
    isAwakeFromNib = YES;
   // self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    lengthOfCode = _length;
    self.backgroundColor = [UIColor clearColor];
    [self setUpWithFrame:self.frame base:self];

}


-(id)initWithFrame:(CGRect)frame baseView:(UIView*)view length:(NSInteger)codeLength{
   
  if (self = [super initWithFrame:frame]) {
    
      self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
      lengthOfCode = codeLength;
      view.backgroundColor = [UIColor clearColor];
      [self setUpWithFrame:frame base:view];
   }
    
    return self;
}


-(void)setUpWithFrame:(CGRect)frame base:(UIView*)view{

    for (int i=0; i<lengthOfCode; i++) {
        
        // NSLog(@"%f", (((view.frame.size.width/2) - (view.frame.size.height * (lengthOfCode / 2)) + 5) > view.frame.size.height ? ((view.frame.size.width/2) - (view.frame.size.height * (lengthOfCode / 2)) + 5) : view.frame.size.height) * (i+1));
        
        ANTextField *txt = [[ANTextField alloc] initWithFrame:CGRectMake(view.frame.size.height * i , 0, view.frame.size.height, view.frame.size.height)];
        txt.keyboardType = UIKeyboardTypeNumberPad;
        txt.textAlignment = NSTextAlignmentCenter;
        txt.textColor = [UIColor whiteColor];
        txt.delegateANTexts = self;
        txt.tag = i + 1;
        
        txt.font = [UIFont systemFontOfSize:17];
        [self addSubview:txt];
        [txt addTarget:self action:@selector(moveToNext:) forControlEvents:UIControlEventEditingChanged];
        [txt addTarget:self action:@selector(removeText:) forControlEvents:UIControlEventEditingDidBegin];
        [txt addTarget:self action:@selector(closeEditing:) forControlEvents:UIControlEventEditingDidEnd];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
        /* placeholder */
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake((view.frame.size.height * i) + 4, txt.frame.size.height - 2, txt.frame.size.width - 8, 2)];
        line.backgroundColor = [UIColor whiteColor];
        [self insertSubview:line belowSubview:txt];
    }
    if (!isAwakeFromNib) {
        
        self.frame = CGRectMake((view.frame.size.width/2) - (view.frame.size.height * (lengthOfCode / 2)), 0, view.frame.size.width, view.frame.size.height);
    }
}

-(void)moveToNext:(ANTextField*)txt{

       if (txt.text.length > 1) {
        
           txt.text = [txt.text substringToIndex:2];
        }
    
        ANTextField *txtField = (ANTextField*)[self viewWithTag:txt.tag+1 ];
        if (txtField != nil && txtField.text.length == 0 && !isDeleting) {
            [txtField becomeFirstResponder];
            
        }else if(txtField.text.length > 0){
           
            return;
        }else{
    
            [self endEditing:YES];
            
        }
}

-(void)removeText:(ANTextField*)txt{

    txt.text = @"";
}

-(void)closeEditing:(ANTextField*)textField{

    isDeleting = NO;
}

#pragma makr - ANTextField Delegate
-(void)textField:(UITextField *)textField replacementString:(NSString *)string{

    isDeleting = YES;
    ANTextField *txtField = (ANTextField*)[self viewWithTag:textField.tag-1 ];
    
    if (![txtField isKindOfClass:[ANPasswcodeView class]]) {
        
        if ([txtField isKindOfClass:[ANTextField class]] && [txtField isKindOfClass:[ANTextField class]] && !([txtField.text length] <=0) && txtField != nil) {
            [txtField becomeFirstResponder];
            
        }else if(txtField.text.length > 0){
            
            return;
        }else{
            
            [self endEditing:YES];
        }
    }

}

@end
