//
//  ANTextField.m
//  HoneyDew
//
//  Created by Ankit Kumar Yadav on 09/02/2017.
//  Copyright © 2017 Pravesh Dubey. All rights reserved.
//

#import "ANTextField.h"

@implementation ANTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)deleteBackward{
    [super deleteBackward];
    
    if (self.text.length == 0) {
        
        if ([self.delegateANTexts respondsToSelector:@selector(textField:replacementString:)]) {
            [self.delegateANTexts textField:self replacementString:@""];
        }
    }
}

@end
