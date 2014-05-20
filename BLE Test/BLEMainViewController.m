
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

AVAudioPlayer *tone00[10];
AVAudioPlayer *tone01[10];
AVAudioPlayer *tone02[10];
AVAudioPlayer *tone03[10];

AVAudioPlayer *tone10[10];
AVAudioPlayer *tone11[10];
AVAudioPlayer *tone12[10];
AVAudioPlayer *tone13[10];

AVAudioPlayer *tone20[10];
AVAudioPlayer *tone21[10];
AVAudioPlayer *tone22[10];
AVAudioPlayer *tone23[10];

AVAudioPlayer *tone30[10];
AVAudioPlayer *tone31[10];
AVAudioPlayer *tone32[10];
AVAudioPlayer *tone33[10];

int _currentChannel=0;

@interface BLEMainViewController ()<UIAlertViewDelegate>{
    
    CBCentralManager    *cm;
    UIAlertView         *currentAlertView;
    UARTPeripheral      *currentPeripheral;
}

@end

@implementation BLEMainViewController

//Keep track of when buttons are being held down
- (IBAction)buttonDown:(UIButton *)sender {
    NSLog(@"buttonDown: %d", sender.tag);
    if(sender.tag==0||sender.tag==1||sender.tag==2||sender.tag==3){
        string0[0]=1;
    }
    if(sender.tag==10||sender.tag==11||sender.tag==12||sender.tag==13){
        string0[1]=1;
    }
    if(sender.tag==20||sender.tag==21||sender.tag==22||sender.tag==23){
        string0[2]=1;
    }

}

//... and when they are released 
- (IBAction)buttonUp:(UIButton *)sender {
    NSLog(@"buttonUp: %d", sender.tag);
    if(sender.tag==0||sender.tag==1||sender.tag==2||sender.tag==3){
        string0[0]=0;
    }
    if(sender.tag==4||sender.tag==5||sender.tag==6||sender.tag==7){
        string0[1]=0;
    }
    if(sender.tag==8||sender.tag==9||sender.tag==10||sender.tag==11){
        string0[2]=0;
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
        tone00[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url00 error:&error];
        tone01[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url01 error:&error];
        tone02[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url02 error:&error];
        tone03[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url03 error:&error];

        tone10[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url10 error:&error];
        tone11[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url11 error:&error];
        tone12[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url12 error:&error];
        tone13[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url13 error:&error];

        tone20[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url20 error:&error];
        tone21[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url21 error:&error];
        tone22[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url22 error:&error];
        tone23[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url23 error:&error];

        tone30[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url30 error:&error];
        tone31[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url31 error:&error];
        tone32[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url32 error:&error];
        tone33[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:url33 error:&error];

    }


    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
        _audioPlayer.delegate = self;
        [_audioPlayer prepareToPlay];

    }
    
    [self.view setAutoresizesSubviews:YES];
	
    
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
        _currentChannel++;
        if (_currentChannel == 10) {
            _currentChannel = 0;
        }
        if([stringNumber isEqual:@"<00>"]){
            NSLog(@"it's zero bro");
                if(string0[0]==1){
                    [tone01[_currentChannel] play];
                }
                else if(string0[1]==1){
                    [tone02[_currentChannel] play];
                
                }
                else if(string0[2]==1){
                    [tone03[_currentChannel] play];

                }
                else{
                    [tone00[_currentChannel] play];

                }
            
        }
        
        else if([stringNumber isEqual:@"<01>"]&&string1!=nil){
            NSLog(@"it's 1 bro");
            if(string1[0]==1){
                [tone11[_currentChannel] play];
            }
            else if(string1[1]==1){
                [tone12[_currentChannel] play];
                
            }
            else if(string1[2]==1){
                [tone13[_currentChannel] play];
                
            }
            else{
                [tone10[_currentChannel] play];
                
            }
            
        }
        
        
        
        else if([stringNumber isEqual:@"<02>"]){

            NSLog(@"it's 2 bro");
            if(string2[0]==1){
                [tone21[_currentChannel] play];
            }
            else if(string2[1]==1){
                [tone22[_currentChannel] play];
                
            }
            else if(string2[2]==1){
                [tone23[_currentChannel] play];
                
            }
            else{
                [tone20[_currentChannel] play];
                
            }

            
        }
        else if([stringNumber isEqual:@"<03>"]){
            NSLog(@"it's 3 bro");
            if(string3[0]==1){
                [tone31[_currentChannel] play];
            }
            else if(string3[1]==1){
                [tone32[_currentChannel] play];
                
            }
            else if(string3[2]==1){
                [tone33[_currentChannel] play];
                
            }
            else{
                [tone30[_currentChannel] play];
                
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

