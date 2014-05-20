
//
//  BLEMainViewController.m
//  Adafruit Bluefruit LE Connect
//
//  Copyright (c) 2013 Adafruit Industries. All rights reserved.
//

#import "BLEMainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+hex.h"
#import "NSData+hex.h"

#define CONNECTING_TEXT @"Connecting…"
#define DISCONNECTING_TEXT @"Disconnecting…"
#define DISCONNECT_TEXT @"Disconnect"
#define CONNECT_TEXT @"Connect"

int string0[3]={0,0,0};
int string1[3]={0,0,0};
int string2[3]={0,0,0};
int string3[3]={0,0,0};

AVAudioPlayer *string00[10];
AVAudioPlayer *string01[10];
AVAudioPlayer *string02[10];
AVAudioPlayer *string03[10];

AVAudioPlayer *string10[10];
AVAudioPlayer *string11[10];
AVAudioPlayer *string12[10];
AVAudioPlayer *string13[10];

AVAudioPlayer *string20[10];
AVAudioPlayer *string21[10];
AVAudioPlayer *string22[10];
AVAudioPlayer *string23[10];

AVAudioPlayer *string30[10];
AVAudioPlayer *string31[10];
AVAudioPlayer *string32[10];
AVAudioPlayer *string33[10];

int _currentChannel1=0;
int _currentChannel2=0;
int _currentChannel3=0;
int _currentChannel4=0;

@interface BLEMainViewController ()<UIAlertViewDelegate>{
    
    CBCentralManager    *cm;
    UIAlertView         *currentAlertView;
    UARTPeripheral      *currentPeripheral;
}

@end

@implementation BLEMainViewController
- (IBAction)button1down:(id)sender {
    NSLog(@"buttonDown: 1");
    string0[0]=1;

}
- (IBAction)button2down:(id)sender {
    NSLog(@"buttonDown: 2");
    string1[0]=1;

}

- (IBAction)button3down:(id)sender {
    NSLog(@"buttonDown: 3");
    string2[0]=1;

}
- (IBAction)button4down:(id)sender {
    NSLog(@"buttonDown: 4");
    string3[0]=1;

}
- (IBAction)button5down:(id)sender {
    NSLog(@"buttonDown: 5");
    string0[1]=1;

}
- (IBAction)button6down:(id)sender {
    NSLog(@"buttonDown: 6");
    string1[1]=1;

}
- (IBAction)button7down:(id)sender {
    NSLog(@"buttonDown: 7");
    string2[1]=1;

}
- (IBAction)button8down:(id)sender {
    NSLog(@"buttonDown: 8");
    string3[1]=1;

}
- (IBAction)button9down:(id)sender {
    NSLog(@"buttonDown: 9");
    string0[2]=1;

}
- (IBAction)button10down:(id)sender {
    NSLog(@"buttonDown: 10");
    string1[2]=1;

}
- (IBAction)button11down:(id)sender {
    NSLog(@"buttonDown: 11");
    string2[2]=1;

}
- (IBAction)button12down:(id)sender {
    NSLog(@"buttondown: 12");
    string3[2]=1;

}


- (IBAction)buttonUp:(id)sender {
    UIButton *btn2 = (UIButton *)sender;
    
    NSString *tone =btn2.titleLabel.text;
    if([tone isEqual:@"tone1"]){
        NSLog(@"buttonup: 1");
        string0[0]=0;
    }
    if([tone isEqual:@"tone2"]){
        NSLog(@"buttonup: 2");
        string1[0]=0;
        
    }
    if([tone isEqual:@"tone3"]){
        NSLog(@"buttonup: 3");
        string2[0]=0;
        
    }
    
    if([tone isEqual:@"tone4"]){
        NSLog(@"buttonup: 4");
        string3[0]=0;
        
    }

    if([tone isEqual:@"tone5"]){
        NSLog(@"buttonup: 5");
        string0[1]=0;
        
    }
    if([tone isEqual:@"tone6"]){
        NSLog(@"buttonup: 6");
        string1[1]=0;
        
    }
    if([tone isEqual:@"tone7"]){
        NSLog(@"buttonup: 7");
        string2[1]=0;
        
    }
    if([tone isEqual:@"tone8"]){
        NSLog(@"buttonup: 8");
        string3[1]=0;
        
    }

    
    if([tone isEqual:@"tone9"]){
        NSLog(@"buttonup: 9");
        string0[2]=0;
        
    }
    if([tone isEqual:@"tone10"]){
        NSLog(@"buttonup: 10");
        string1[2]=0;
        
    }
    if([tone isEqual:@"tone11"]){
        NSLog(@"buttonup: 11");
        string2[2]=0;
        
    }
    if([tone isEqual:@"tone12"]){
        NSLog(@"buttonup: 12");
        string3[2]=0;
        
    }


}

#pragma mark - View Lifecycle


- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil{
    
    //Separate NIBs for iPhone 3.5", iPhone 4", & iPad
    
    NSString *nibName;
    
        nibName = @"BLEMainViewController_iPhone";
    
    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    NSURL *url00 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"string00"
                                         ofType:@"wav"]];
    NSURL *url01 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"string01"
                                          ofType:@"wav"]];
    NSURL *url02 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"string02"
                                          ofType:@"wav"]];
    NSURL *url03 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"string03"
                                          ofType:@"wav"]];
    
    NSURL *url10 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"string10"
                                          ofType:@"wav"]];
    NSURL *url11 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"string11"
                                          ofType:@"wav"]];
    NSURL *url12 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"string12"
                                          ofType:@"wav"]];
    NSURL *url13 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"string13"
                                          ofType:@"wav"]];

    NSURL *url20 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                           pathForResource:@"string20"
                                           ofType:@"wav"]];
    NSURL *url21 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                           pathForResource:@"string21"
                                           ofType:@"wav"]];
    NSURL *url22 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                           pathForResource:@"string22"
                                           ofType:@"wav"]];
    NSURL *url23 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                           pathForResource:@"string23"
                                           ofType:@"wav"]];
    
    NSURL *url30 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                           pathForResource:@"string30"
                                           ofType:@"wav"]];
    NSURL *url31 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                           pathForResource:@"string31"
                                           ofType:@"wav"]];
    NSURL *url32 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                           pathForResource:@"string32"
                                           ofType:@"wav"]];
    NSURL *url33 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                           pathForResource:@"string33"
                                           ofType:@"wav"]];

    NSError *error;
    for(int i=0;i<10;i++){
        string00[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url00 error:&error];
        string01[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url01 error:&error];
        string02[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url02 error:&error];
        string03[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url03 error:&error];

        string10[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url10 error:&error];
        string11[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url11 error:&error];
        string12[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url12 error:&error];
        string13[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url13 error:&error];

        string20[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url20 error:&error];
        string21[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url21 error:&error];
        string22[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url22 error:&error];
        string23[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url23 error:&error];

        string30[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url30 error:&error];
        string31[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url31 error:&error];
        string32[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url32 error:&error];
        string33[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url33 error:&error];

    }

//    tone1 = [[AVAudioPlayer alloc]
//                    initWithContentsOfURL:url1
//                    error:&error];
//    tone2 = [[AVAudioPlayer alloc]
//                    initWithContentsOfURL:url2
//                    error:&error];
//    tone3 = [[AVAudioPlayer alloc]
//             initWithContentsOfURL:url3
//             error:&error];
//    tone4 = [[AVAudioPlayer alloc]
//             initWithContentsOfURL:url4
//             error:&error];
//    tone5 = [[AVAudioPlayer alloc]
//             initWithContentsOfURL:url5
//             error:&error];
//    tone6 = [[AVAudioPlayer alloc]
//             initWithContentsOfURL:url6
//             error:&error];

    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
        _audioPlayer.delegate = self;
        [_audioPlayer prepareToPlay];

    }
    
    [self.view setAutoresizesSubviews:YES];
    
    //UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(0,0,200,50)];
    //label1.text=@"hello2!";
    //[self.view addSubview:label1];
	
    
    cm = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    _connectionMode = ConnectionModeUART;
    
    _connectionStatus = ConnectionStatusScanning;
    
    
    [self scanForPeripherals];
    
    currentAlertView = [[UIAlertView alloc]initWithTitle:@"Scanning …"
                                                 message:nil
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:nil];
    
    [currentAlertView show];

}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload{
    
    [super viewDidUnload];
}


#pragma mark - Root UI






- (IBAction)buttonTapped:(UIButton*)sender{
    
    //Called by Pin I/O or UART Monitor connect buttons
    
    
}


- (void)scanForPeripherals{
    
    //Look for available Bluetooth LE devices
    
    //skip scanning if UART is already connected
    NSArray *connectedPeripherals = [cm retrieveConnectedPeripheralsWithServices:@[UARTPeripheral.uartServiceUUID]];
    if ([connectedPeripherals count] > 0) {
        //connect to first peripheral in array
        [self connectPeripheral:[connectedPeripherals objectAtIndex:0]];
    }
    
    else{
        
        [cm scanForPeripheralsWithServices:@[UARTPeripheral.uartServiceUUID]
                                   options:@{CBCentralManagerScanOptionAllowDuplicatesKey: [NSNumber numberWithBool:NO]}];
    }
    
}


- (void)connectPeripheral:(CBPeripheral*)peripheral{
    
    //Connect Bluetooth LE device
    
    //Clear off any pending connections
    [cm cancelPeripheralConnection:peripheral];
    
    //Connect
    currentPeripheral = [[UARTPeripheral alloc] initWithPeripheral:peripheral delegate:self];
    [cm connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey: [NSNumber numberWithBool:YES]}];
    
}


- (void)disconnect{
    
    //Disconnect Bluetooth LE device
    
    _connectionStatus = ConnectionStatusDisconnected;
    _connectionMode = ConnectionModeNone;
    
    [cm cancelPeripheralConnection:currentPeripheral.peripheral];
    
}



#pragma mark UIAlertView delegate methods


- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //the only button in our alert views is cancel, no need to check button index
    
    if (_connectionStatus == ConnectionStatusConnected) {
        [self disconnect];
    }
    else if (_connectionStatus == ConnectionStatusScanning){
        [cm stopScan];
    }
    
    _connectionStatus = ConnectionStatusDisconnected;
    _connectionMode = ConnectionModeNone;
    
    currentAlertView = nil;
    
    
    //alert dismisses automatically @ return
    
}


#pragma mark Navigation Controller delegate methods


- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated{
    
    //disconnect when returning to main view
    if (_connectionStatus == ConnectionStatusConnected) {
        [self disconnect];
        
        //dismiss UART keyboard
    }
    
}


#pragma mark CBCentralManagerDelegate


- (void) centralManagerDidUpdateState:(CBCentralManager*)central{
    
    if (central.state == CBCentralManagerStatePoweredOn){
        
        //respond to powered on
    }
    
    else if (central.state == CBCentralManagerStatePoweredOff){
        
        //respond to powered off
    }
    
}


- (void) centralManager:(CBCentralManager*)central didDiscoverPeripheral:(CBPeripheral*)peripheral advertisementData:(NSDictionary*)advertisementData RSSI:(NSNumber*)RSSI{
    
    NSLog(@"Did discover peripheral %@", peripheral.name);
    
    [cm stopScan];
    
    [self connectPeripheral:peripheral];
}


- (void) centralManager:(CBCentralManager*)central didConnectPeripheral:(CBPeripheral*)peripheral{
    
    if ([currentPeripheral.peripheral isEqual:peripheral]){
        
        if(peripheral.services){
            NSLog(@"Did connect to existing peripheral %@", peripheral.name);
            [currentPeripheral peripheral:peripheral didDiscoverServices:nil]; //already discovered services, DO NOT re-discover. Just pass along the peripheral.
        }
        
        else{
            NSLog(@"Did connect peripheral %@", peripheral.name);
            [currentPeripheral didConnect];
        }
    }
}


- (void) centralManager:(CBCentralManager*)central didDisconnectPeripheral:(CBPeripheral*)peripheral error:(NSError*)error{
    
    NSLog(@"Did disconnect peripheral %@", peripheral.name);
    
    //respond to disconnected
    [self peripheralDidDisconnect];
    
    if ([currentPeripheral.peripheral isEqual:peripheral])
    {
        [currentPeripheral didDisconnect];
    }
}


#pragma mark UARTPeripheralDelegate


- (void)didReadHardwareRevisionString:(NSString*)string{
    
    //Once hardware revision string is read, connection to Bluefruit is complete
    
    NSLog(@"HW Revision: %@", string);
    
    //Bail if we aren't in the process of connecting
    if (currentAlertView == nil){
        return;
    }
    
    _connectionStatus = ConnectionStatusConnected;
    
    //Load appropriate view controller …
    
    
    //UART mode

    //Dismiss Alert view & update main view
    [currentAlertView dismissWithClickedButtonIndex:-1 animated:NO];
    
    //Push appropriate viewcontroller onto the navcontroller
    
    
    currentAlertView = nil;
    
    
}


- (void)uartDidEncounterError:(NSString*)error{
    
    //Dismiss "scanning …" alert view if shown
    if (currentAlertView != nil) {
        [currentAlertView dismissWithClickedButtonIndex:0 animated:NO];
    }
    
    //Display error alert
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                   message:error
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    
    [alert show];
    
}


- (void)didReceiveData:(NSData*)newData{
    
    //Data incoming from UART peripheral, forward to current view controller

    //Debug
//    NSString *hexString = [newData hexRepresentationWithSpaces:YES];
//    NSLog(@"Received: %@", newData);
    
    if (_connectionStatus == ConnectionStatusConnected || _connectionStatus == ConnectionStatusScanning) {
        //UART

        //send data to UART Controller
        NSString* stringNumber = [NSString stringWithFormat:@"%@", newData];
        if([stringNumber isEqual:@"<00>"]){
            _currentChannel1++;
            if (_currentChannel1 == 10) {
                _currentChannel1 = 0;
            }

            NSLog(@"it's zero bro");
                if(string0[0]==1){
                    [string01[_currentChannel1] play];
                }
                else if(string0[1]==1){
                    [string02[_currentChannel1] play];
                
                }
                else if(string0[2]==1){ //FUNKAR INTE
                    [string03[_currentChannel1] play];

                }
                else{
                    [string00[_currentChannel1] play];

                }
            
        }
        
        else if([stringNumber isEqual:@"<01>"]&&string1!=nil){
            _currentChannel2++;
            if (_currentChannel2 == 10) {
                _currentChannel2 = 0;
            }

            NSLog(@"it's 1 bro");
            if(string1[0]==1){
                [string11[_currentChannel2] play];
            }
            else if(string1[1]==1){
                [string12[_currentChannel2] play];
                
            }
            else if(string1[2]==1){ //FUNKAR EJ
                [string13[_currentChannel2] play];
                
            }
            else{
                [string10[_currentChannel2] play];
                
            }
            
        }
        
        
        
        else if([stringNumber isEqual:@"<02>"]){
            _currentChannel3++;
            if (_currentChannel3 == 10) {
                _currentChannel3 = 0;
            }


            NSLog(@"it's 2 bro");
            if(string2[0]==1){
                [string21[_currentChannel3] play];
            }
            else if(string2[1]==1){
                [string22[_currentChannel3] play];
                
            }
            else if(string2[2]==1){ //FUNKAR INTE
                [string23[_currentChannel3] play];
                
            }
            else{
                [string20[_currentChannel3] play];
                
            }

            
        }
        else if([stringNumber isEqual:@"<03>"]){
            _currentChannel4++;
            if (_currentChannel4 == 10) {
                _currentChannel4 = 0;
            }
       

            NSLog(@"it's 3 bro");
            if(string3[0]==1){
                [string31[_currentChannel4] play];
            }
            else if(string3[1]==1){
                [string32[_currentChannel4] play];
                
            }
            else if(string3[2]==1){ //FUNKAR INTE
                [string33[_currentChannel4] play];
                
            }
            else{
                [string30[_currentChannel4] play];
                
            }
            }
        }
    

    
}


- (void)peripheralDidDisconnect{
    
    //respond to device disconnecting
    
    //if we were in the process of scanning/connecting, dismiss alert
    if (currentAlertView != nil) {
        [self uartDidEncounterError:@"Peripheral disconnected"];
    }
    
    //if status was connected, then disconnect was unexpected by the user, show alert
    if (_connectionStatus == ConnectionStatusConnected) {
        
        
        //display disconnect alert
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Disconnected"
                                                       message:@"BLE peripheral has disconnected"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles: nil];
        
        [alert show];
    }
    
    _connectionStatus = ConnectionStatusDisconnected;
    _connectionMode = ConnectionModeNone;
    
    //dereference mode controllers
    
    //make reconnection available after short delay
    [self performSelector:@selector(enableConnectionButtons) withObject:nil afterDelay:1.0f];
    
}


- (void)alertBluetoothPowerOff{
    
    //Respond to system's bluetooth disabled
    
    NSString *title     = @"Bluetooth Power";
    NSString *message   = @"You must turn on Bluetooth in Settings in order to connect to a device";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


- (void)alertFailedConnection{
    
    //Respond to unsuccessful connection
    
    NSString *title     = @"Unable to connect";
    NSString *message   = @"Please check power & wiring,\nthen reset your Arduino";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
}




- (void)sendData:(NSData*)newData{
    
    //Output data to UART peripheral
    
    NSString *hexString = [newData hexRepresentationWithSpaces:YES];
    NSLog(@"Sending: %@", hexString);
    
    [currentPeripheral writeRawData:newData];
    
}

//- (IBAction)onButtonHeldDown:(UIButton *)sender {
//    UIButton *resultButton = (UIButton *)sender;
//    NSLog(@" The button's title is %@." resultButton.currentTitle);
//}
//
////- (IBAction)onButtonHeldDown:(id)sender {
//   // NSLog(@"Did tap button %@", id);
////}
//- (IBAction)touchDownOnButton:(UIButton *)sender {
//    NSLog(@"Did tap button %d", (int)[self.tones indexOfObject:sender]);
//}

@end

