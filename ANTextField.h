//
//  ANTextField.h
//  HoneyDew
//
//  Created by Ankit Kumar Yadav on 09/02/2017.
//  Copyright © 2017 Pravesh Dubey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ANTextFiledDelegate <NSObject, UITextFieldDelegate>

-(void)textField:(UITextField*)textField replacementString:(NSString*)string;

@end

@interface ANTextField : UITextField


@property(nonatomic, assign) id<ANTextFiledDelegate> delegateANTexts;

@end
