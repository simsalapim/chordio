
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

AVAudioPlayer *tone[10];

int amountOfFrets=3;
int amountOfStrings=4;
int amountOfTones=16;

int _currentChannelBaseToneString0=0;
int _currentChannelBaseToneString1=0;
int _currentChannelBaseToneString2=0;
int _currentChannelBaseToneString3=0;

//Used when creating string buttons
int _currentHeightString0=0;
int _currentHeightString1=0;
int _currentHeightString2=0;
int _currentHeightString3=0;

@interface BLEMainViewController ()<UIAlertViewDelegate>{

    NSMutableArray *string0;
    NSMutableArray *string1;
    NSMutableArray *string2;
    NSMutableArray *string3;
    
    NSMutableArray *tonesOfString0;
    NSMutableArray *tonesOfString1;
    NSMutableArray *tonesOfString2;
    NSMutableArray *tonesOfString3;
    NSMutableArray *tonesOfStringInner;

    
    CBCentralManager    *cm;
    UIAlertView         *currentAlertView;
    UARTPeripheral      *currentPeripheral;

}

@property(nonatomic,retain) IBOutlet UIScrollView *scrollview;


@end



@implementation BLEMainViewController


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
    string0=[[NSMutableArray alloc] init];
    string1=[[NSMutableArray alloc] init];
    string2=[[NSMutableArray alloc] init];
    string3=[[NSMutableArray alloc] init];
    
    tonesOfString0=[[NSMutableArray alloc] init];
    tonesOfString1=[[NSMutableArray alloc] init];
    tonesOfString2=[[NSMutableArray alloc] init];
    tonesOfString3=[[NSMutableArray alloc] init];
    //create the buttons
    for (int i=0; i<amountOfTones; i++){
        //create buttons
        UIButton *button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //Attach events
        [button addTarget:self action:@selector(buttonDown:) forControlEvents:(UIControlEventTouchDown)];
        [button addTarget:self action:@selector(buttonUp:) forControlEvents:(UIControlEventTouchUpInside)];
        [button addTarget:self action:@selector(buttonUp:) forControlEvents:(UIControlEventTouchUpOutside)];
        [button setBackgroundColor:( [UIColor grayColor])];
        
        //Generate tones
        tonesOfStringInner=[[NSMutableArray alloc] init];
        NSString *toneName =[NSString stringWithFormat:@"tone-%d",i];
        NSURL *toneURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                 pathForResource:toneName
                                                 ofType:@"wav"]];
        NSError *error;
        for (int h=0; h<10; h++) {
            tone[h] = [[AVAudioPlayer alloc] initWithContentsOfURL:toneURL error:&error];
            [tonesOfStringInner addObject:tone[h]];
            
        }
        
        if (error)
        {
            NSLog(@"Error in audioPlayer: %@",
                  [error localizedDescription]);
        } else {
            tone[0].delegate = self;
            [tone[0] prepareToPlay];
            
            //first string
            if(i<amountOfTones/4){
                
                [tonesOfString0 addObject:tonesOfStringInner];
                //Set tags to 0,10,20,30 ...
                [button setTag:i*10];
                [button setFrame:CGRectMake(20, _currentHeightString0, 30, 180/pow(1.059263,i))];
                _currentHeightString0=_currentHeightString0+10+180/pow(1.059263,i);
                button.selected=false;
                [string0 addObject:button];
                
            }
            //second string
            else if(i>=amountOfTones/4&&i<amountOfTones/2){
                [tonesOfString1 addObject:tonesOfStringInner];
                
                //Set tags to 1,11,21,31 ...
                [button setTag:(i-amountOfTones/4)*10+1];
                //Proportion between two nearby frets is 1:1.059263
                [button setFrame:CGRectMake(100, _currentHeightString1, 30, 180/pow(1.059263,i-amountOfTones/4))];
                _currentHeightString1=_currentHeightString1+10+180/pow(1.059263,i-amountOfTones/4);
                [string1 addObject:button];
                
            }
            //third string
            else if(i>=amountOfTones/2&&i<3*amountOfTones/4){
                [tonesOfString2 addObject:tonesOfStringInner];
                
                //Set tags to 2,12,22,32 ...
                [button setTag:(i-amountOfTones/2)*10+2];
                [button setFrame:CGRectMake(180, _currentHeightString2, 30, 180/pow(1.059263,i-amountOfTones/2))];
                _currentHeightString2=_currentHeightString2+10+180/pow(1.059263,i-amountOfTones/2);
                [string2 addObject:button];
                
            }
            //fourth string
            else{
                [tonesOfString3 addObject:tonesOfStringInner];
                
                //Set tags to 3,13,23,33 ...
                [button setTag:(i-3*amountOfTones/4)*10+3];
                [button setFrame:CGRectMake(260, _currentHeightString3, 30, 180/pow(1.059263,i-3*amountOfTones/4))];
                _currentHeightString3=_currentHeightString3+10+180/pow(1.059263,i-3*amountOfTones/4);
                [string3 addObject:button];
                
            }
        }
        
        [self.view addSubview:button];
    };
    
    //Load the tones and put the players in an array correlating to what string the tone should be on
    
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

//Call when buttons are pressed
- (IBAction)buttonDown:(UIButton *)sender {
    int tag=sender.tag;
    NSLog(@"buttonDown: %d",tag);
    sender.selected=TRUE;
    
}

//... and when they are released
- (IBAction)buttonUp:(UIButton *)sender {
    sender.selected=FALSE;
    
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



//Receive data when a string has been touched
- (void)didReceiveData:(NSData*)newData{
    
    //Data incoming from UART peripheral, forward to current view controller
    
    if (_connectionStatus == ConnectionStatusConnected || _connectionStatus == ConnectionStatusScanning) {
        
        //send data to UART Controller
        NSString* stringNumber = [NSString stringWithFormat:@"%@", newData];

        bool baseToneShouldPlay=TRUE;
        
        if([stringNumber isEqual:@"<00>"]){
            NSLog(@"string 0 played");
            for (int i=string0.count-1; i>=0; i--) {
                // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[string0 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    baseToneShouldPlay=FALSE;
                    if(buttonOnString.tag>=10){
                        buttonOnString.tag=0;
                    }
                    NSMutableArray *playerArray = [tonesOfString0 objectAtIndex:i+1];
                    AVAudioPlayer *toneToPlay = [playerArray objectAtIndex:buttonOnString.tag];
                    [toneToPlay play];
                    buttonOnString.tag+=1;
                    return;
                    
                }
            }
            if(baseToneShouldPlay){
                if(_currentChannelBaseToneString0>=10){
                    _currentChannelBaseToneString0=0;
                }

                NSMutableArray *toneArray = [tonesOfString0 objectAtIndex:0];
                AVAudioPlayer *toneToPlay = [toneArray objectAtIndex:_currentChannelBaseToneString0];
                _currentChannelBaseToneString0++;
                [toneToPlay play];
                
            }
            
        }
        
        else if([stringNumber isEqual:@"<01>"]){
            NSLog(@"string 1 played");
            for (int i=string1.count-1; i>=0; i--) {
                // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[string1 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    baseToneShouldPlay=FALSE;
                    if(buttonOnString.tag>=10){
                        buttonOnString.tag=0;
                    }
                    NSMutableArray *playerArray = [tonesOfString1 objectAtIndex:i+1];
                    AVAudioPlayer *toneToPlay = [playerArray objectAtIndex:buttonOnString.tag];
                    [toneToPlay play];
                    buttonOnString.tag+=1;
                    return;
                    
                }
            }
            if(baseToneShouldPlay){
                if(_currentChannelBaseToneString1>=10){
                    _currentChannelBaseToneString1=0;
                }

                NSMutableArray *toneArray = [tonesOfString1 objectAtIndex:0];
                AVAudioPlayer *toneToPlay = [toneArray objectAtIndex:_currentChannelBaseToneString1];
                _currentChannelBaseToneString1++;
                [toneToPlay play];
                
            }
            
        }
        
        
        
        else if([stringNumber isEqual:@"<02>"]){
            NSLog(@"string 2 played");
            for (int i=string2.count-1; i>=0; i--) {
               // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[string2 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    baseToneShouldPlay=FALSE;
                    if(buttonOnString.tag>=10){
                        buttonOnString.tag=0;
                    }
                    NSMutableArray *playerArray = [tonesOfString2 objectAtIndex:i+1];
                    AVAudioPlayer *toneToPlay = [playerArray objectAtIndex:buttonOnString.tag];
                    [toneToPlay play];
                    buttonOnString.tag+=1;

                    return;

                }
            }
            if(baseToneShouldPlay){
                if(_currentChannelBaseToneString2>=10){
                    _currentChannelBaseToneString2=0;
                }

                NSMutableArray *toneArray = [tonesOfString2 objectAtIndex:0];
                AVAudioPlayer *toneToPlay = [toneArray objectAtIndex:_currentChannelBaseToneString2];
                _currentChannelBaseToneString2++;
                [toneToPlay play];

            }
            
        }
        else if([stringNumber isEqual:@"<03>"]){
            NSLog(@"string 3 played");
            for (int i=string3.count-1; i>=0; i--) {
                // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[string3 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    baseToneShouldPlay=FALSE;
                    if(buttonOnString.tag>=10){
                        buttonOnString.tag=0;
                    }

                    NSMutableArray *playerArray = [tonesOfString3 objectAtIndex:i+1];
                    AVAudioPlayer *toneToPlay = [playerArray objectAtIndex:buttonOnString.tag];
                    [toneToPlay play];
                    buttonOnString.tag+=1;

                    return;
                    
                }
            }
            if(baseToneShouldPlay){
                if(baseToneShouldPlay){
                    if(_currentChannelBaseToneString3>=10){
                        _currentChannelBaseToneString3=0;
                    }
                    

                NSMutableArray *toneArray = [tonesOfString3 objectAtIndex:0];
                AVAudioPlayer *toneToPlay = [toneArray objectAtIndex:_currentChannelBaseToneString3];
                _currentChannelBaseToneString3++;
                [toneToPlay play];
                
            }
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


@end

