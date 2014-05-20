//
//  UARTViewController.m
//  Bluefruit Connect
//
//  Created by Adafruit Industries on 2/5/14.
//  Copyright (c) 2014 Adafruit Industries. All rights reserved.
//

#import "UARTViewController.h"
#import "NSString+hex.h"
#import "NSData+hex.h"

#define kKeyboardAnimationDuration 0.3f

@interface UARTViewController(){
    
    NSString    *unkownCharString;
    
}

@end

@implementation UARTViewController


- (id)initWithDelegate:(id<UARTViewControllerDelegate>)aDelegate{
    
    //Separate NIBs for iPhone 3.5", iPhone 4", & iPad
    
    NSString *nibName;
    
        nibName = @"UARTViewController_iPhone";
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    
    if (self){
        self.delegate = aDelegate;
        self.title = @"UART";
    }
    
    return self;
    
}


- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil{
    
    //Separate NIBs for iPhone 3.5", iPhone 4", & iPad
    
    NSString *nibName;
    
        nibName = @"UARTViewController_iPhone";
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}


#pragma mark - View Lifecycle


- (void)viewDidLoad{
    
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload{
    
    [self setConsoleView:nil];
    [self setInputField:nil];
    [self setSendButton:nil];
    [self setConsoleModeControl:nil];
    
    //unregister for keyboard notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [super viewDidUnload];
    
}


- (void)updateConsoleWithIncomingData:(NSData*)newData {
    
    //Write new received data to the console text view
    
    //convert data to string & replace characters we can't display
   

}


- (void)updateConsoleWithOutgoingString:(NSString*)newString{
    
}


- (void)updateConsoleButtons{
    
    
}


- (void)resetUI{
    
    
}


- (IBAction)clearConsole:(id)sender{
    
}


- (IBAction)copyConsole:(id)sender{
    
    
}


- (IBAction)sendMessage:(id)sender{
    
    
}


- (void)receiveData:(NSData*)newData{
    
    //Receive data from device
    NSLog(@"StringTouched: %@", newData);

    
}






- (void)didConnect{
    
    //Respond to connection
    
    [self resetUI];
    
}


@end
