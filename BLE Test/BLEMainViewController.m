
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
#import "ObjectAL.h"

#define CONNECTING_TEXT @"Connecting…"
#define DISCONNECTING_TEXT @"Disconnecting…"
#define DISCONNECT_TEXT @"Disconnect"
#define CONNECT_TEXT @"Connect"

#define TONE0 @"string0tone0.wav"
#define TONE1 @"string0tone1.wav"
#define TONE2 @"string0tone2.wav"
#define TONE3 @"string0tone3.wav"
#define TONE4 @"string0tone4.wav"
#define TONE5 @"string0tone5.wav"
#define TONE6 @"string0tone6.wav"
#define TONE7 @"string0tone7.wav"
#define TONE8 @"string0tone8.wav"
#define TONE9 @"string0tone9.wav"
#define TONE10 @"string0tone10.wav"
#define TONE11 @"string0tone11.wav"
#define TONE12 @"string0tone12.wav"
#define TONE13 @"string1tone0.wav"
#define TONE14 @"string1tone1.wav"
#define TONE15 @"string1tone2.wav"
#define TONE16 @"string1tone3.wav"
#define TONE17 @"string1tone4.wav"
#define TONE18 @"string1tone5.wav"
#define TONE19 @"string1tone6.wav"
#define TONE20 @"string1tone7.wav"
#define TONE21 @"string1tone8.wav"
#define TONE22 @"string1tone9.wav"
#define TONE23 @"string1tone10.wav"
#define TONE24 @"string1tone11.wav"
#define TONE25 @"string1tone12.wav"
#define TONE26 @"string2tone0.wav"
#define TONE27 @"string2tone1.wav"
#define TONE28 @"string2tone2.wav"
#define TONE29 @"string2tone3.wav"
#define TONE30 @"string2tone4.wav"
#define TONE31 @"string2tone5.wav"
#define TONE32 @"string2tone6.wav"
#define TONE33 @"string2tone7.wav"
#define TONE34 @"string2tone8.wav"
#define TONE35 @"string2tone9.wav"
#define TONE36 @"string2tone10.wav"
#define TONE37 @"string2tone11.wav"
#define TONE38 @"string2tone12.wav"
#define TONE39 @"string3tone0.wav"
#define TONE40 @"string3tone1.wav"
#define TONE41 @"string3tone2.wav"
#define TONE42 @"string3tone3.wav"
#define TONE43 @"string3tone4.wav"
#define TONE44 @"string3tone5.wav"
#define TONE45 @"string3tone6.wav"
#define TONE46 @"string3tone7.wav"
#define TONE47 @"string3tone8.wav"
#define TONE48 @"string3tone9.wav"
#define TONE49 @"string3tone10.wav"
#define TONE50 @"string3tone11.wav"
#define TONE51 @"string3tone12.wav"
#define TONE52 @"string4tone0.wav"
#define TONE53 @"string4tone1.wav"
#define TONE54 @"string4tone2.wav"
#define TONE55 @"string4tone3.wav"
#define TONE56 @"string4tone4.wav"
#define TONE57 @"string4tone5.wav"
#define TONE58 @"string4tone6.wav"
#define TONE59 @"string4tone7.wav"
#define TONE60 @"string4tone8.wav"
#define TONE61 @"string4tone9.wav"
#define TONE62 @"string4tone10.wav"
#define TONE63 @"string4tone11.wav"
#define TONE64 @"string4tone12.wav"
#define TONE65 @"string5tone0.wav"
#define TONE66 @"string5tone1.wav"
#define TONE67 @"string5tone2.wav"
#define TONE68 @"string5tone3.wav"
#define TONE69 @"string5tone4.wav"
#define TONE70 @"string5tone5.wav"
#define TONE71 @"string5tone6.wav"
#define TONE72 @"string5tone7.wav"
#define TONE73 @"string5tone8.wav"
#define TONE74 @"string5tone9.wav"
#define TONE75 @"string5tone10.wav"
#define TONE76 @"string5tone11.wav"
#define TONE77 @"string5tone12.wav"

int amountOfFrets=12;
int amountOfStrings=6;
int amountOfTones=77;


//Vertical position on screen
int verticalPosition=0;
int scrollViewHeight=1605;
@interface BLEMainViewController ()<UIAlertViewDelegate>{

    NSMutableArray *buttonsOfString0;
    NSMutableArray *buttonsOfString1;
    NSMutableArray *buttonsOfString2;
    NSMutableArray *buttonsOfString3;
    NSMutableArray *buttonsOfString4;
    NSMutableArray *buttonsOfString5;

    
    NSMutableArray *tonesOfString0;
    NSMutableArray *tonesOfString1;
    NSMutableArray *tonesOfString2;
    NSMutableArray *tonesOfString3;
    NSMutableArray *tonesOfString4;
    NSMutableArray *tonesOfString5;

    //Inner array of players
    NSMutableArray *tonesOfStringInner;
    
    CBCentralManager    *cm;
    UIAlertView         *currentAlertView;
    UARTPeripheral      *currentPeripheral;

}

@property(nonatomic,retain) IBOutlet UIScrollView *scrollview;
@property(nonatomic,retain) IBOutlet UIView *lineView;


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

    //Create scroll view
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;

    scrollView = [[UIScrollView alloc]initWithFrame: CGRectMake(0, 0, width, scrollViewHeight)];
    self.view = scrollView;
    scrollView.backgroundColor=[UIColor whiteColor];
    scrollView.scrollEnabled=YES;
    scrollView.contentSize = CGSizeMake(width, scrollViewHeight);
    
    float currentHeight=0;
    NSMutableArray *startingHeights = [[NSMutableArray alloc] init];

    //Create an array with the y coordinates for the buttons
    for(int i=0;i<amountOfFrets+2;i++){
       // NSLog(@"%f",currentHeight);
        NSNumber *num = [NSNumber numberWithFloat:currentHeight];
        [startingHeights addObject:num];
        currentHeight=currentHeight+180/pow(1.059263,i);
    };

    buttonsOfString0=[[NSMutableArray alloc] init];
    buttonsOfString1=[[NSMutableArray alloc] init];
    buttonsOfString2=[[NSMutableArray alloc] init];
    buttonsOfString3=[[NSMutableArray alloc] init];
    buttonsOfString4=[[NSMutableArray alloc] init];
    buttonsOfString5=[[NSMutableArray alloc] init];
    
    tonesOfString0=[[NSMutableArray alloc] init];
    tonesOfString1=[[NSMutableArray alloc] init];
    tonesOfString2=[[NSMutableArray alloc] init];
    tonesOfString3=[[NSMutableArray alloc] init];
    tonesOfString4=[[NSMutableArray alloc] init];
    tonesOfString5=[[NSMutableArray alloc] init];

    
    [tonesOfString0 addObject: TONE0];
    [tonesOfString0 addObject: TONE1];
    [tonesOfString0 addObject: TONE2];
    [tonesOfString0 addObject: TONE3];
    [tonesOfString0 addObject: TONE4];
    [tonesOfString0 addObject: TONE5];
    [tonesOfString0 addObject: TONE6];
    [tonesOfString0 addObject: TONE7];
    [tonesOfString0 addObject: TONE8];
    [tonesOfString0 addObject: TONE9];
    [tonesOfString0 addObject: TONE10];
    [tonesOfString0 addObject: TONE11];
    [tonesOfString0 addObject: TONE12];
    
    [tonesOfString1 addObject: TONE13];
    [tonesOfString1 addObject: TONE14];
    [tonesOfString1 addObject: TONE15];
    [tonesOfString1 addObject: TONE16];
    [tonesOfString1 addObject: TONE17];
    [tonesOfString1 addObject: TONE18];
    [tonesOfString1 addObject: TONE19];
    [tonesOfString1 addObject: TONE20];
    [tonesOfString1 addObject: TONE21];
    [tonesOfString1 addObject: TONE22];
    [tonesOfString1 addObject: TONE23];
    [tonesOfString1 addObject: TONE24];
    [tonesOfString1 addObject: TONE25];
    
    [tonesOfString2 addObject: TONE26];
    [tonesOfString2 addObject: TONE27];
    [tonesOfString2 addObject: TONE28];
    [tonesOfString2 addObject: TONE29];
    [tonesOfString2 addObject: TONE30];
    [tonesOfString2 addObject: TONE31];
    [tonesOfString2 addObject: TONE32];
    [tonesOfString2 addObject: TONE33];
    [tonesOfString2 addObject: TONE34];
    [tonesOfString2 addObject: TONE35];
    [tonesOfString2 addObject: TONE36];
    [tonesOfString2 addObject: TONE37];
    [tonesOfString2 addObject: TONE38];
    
    [tonesOfString3 addObject: TONE39];
    [tonesOfString3 addObject: TONE40];
    [tonesOfString3 addObject: TONE41];
    [tonesOfString3 addObject: TONE42];
    [tonesOfString3 addObject: TONE43];
    [tonesOfString3 addObject: TONE44];
    [tonesOfString3 addObject: TONE45];
    [tonesOfString3 addObject: TONE46];
    [tonesOfString3 addObject: TONE47];
    [tonesOfString3 addObject: TONE48];
    [tonesOfString3 addObject: TONE49];
    [tonesOfString3 addObject: TONE50];
    [tonesOfString3 addObject: TONE51];
    
    [tonesOfString4 addObject: TONE52];
    [tonesOfString4 addObject: TONE53];
    [tonesOfString4 addObject: TONE54];
    [tonesOfString4 addObject: TONE55];
    [tonesOfString4 addObject: TONE56];
    [tonesOfString4 addObject: TONE57];
    [tonesOfString4 addObject: TONE58];
    [tonesOfString4 addObject: TONE59];
    [tonesOfString4 addObject: TONE60];
    [tonesOfString4 addObject: TONE61];
    [tonesOfString4 addObject: TONE62];
    [tonesOfString4 addObject: TONE63];
    [tonesOfString4 addObject: TONE64];
    
    [tonesOfString5 addObject: TONE65];
    [tonesOfString5 addObject: TONE66];
    [tonesOfString5 addObject: TONE67];
    [tonesOfString5 addObject: TONE68];
    [tonesOfString5 addObject: TONE69];
    [tonesOfString5 addObject: TONE70];
    [tonesOfString5 addObject: TONE71];
    [tonesOfString5 addObject: TONE72];
    [tonesOfString5 addObject: TONE73];
    [tonesOfString5 addObject: TONE74];
    [tonesOfString5 addObject: TONE75];
    [tonesOfString5 addObject: TONE76];
    [tonesOfString5 addObject: TONE77];


    //create one button for each tone
    for (int i=0; i<amountOfTones; i++){
        //create buttons
        UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
        //Attach events
        [button addTarget:self action:@selector(buttonDown:) forControlEvents:(UIControlEventTouchDown)];
        [button addTarget:self action:@selector(buttonUp:) forControlEvents:(UIControlEventTouchUpInside)];
        [button addTarget:self action:@selector(buttonUp:) forControlEvents:(UIControlEventTouchUpOutside)];
        [button setBackgroundColor:( [UIColor clearColor])];
        button.adjustsImageWhenHighlighted = FALSE;
        [button setTag:i];
        //button.layer.borderColor = [UIColor blackColor].CGColor;
        //button.layer.borderWidth = 1.0;
        //button.layer.cornerRadius = 0;
        button.selected=false;
        float startingHeight;
        float heightOfButton;
        float nextStartingHeight;

            //first string
            if(i<amountOfFrets){
                startingHeight=[[startingHeights objectAtIndex:i] floatValue];
                if(i==0){
                    heightOfButton=180;
                }
                else{
                    nextStartingHeight=[[startingHeights objectAtIndex:i+1] floatValue];
                    heightOfButton= nextStartingHeight-startingHeight;
                }
                [button setFrame:CGRectMake(0, startingHeight, width/amountOfStrings, heightOfButton)];
                [buttonsOfString0 addObject:button];
            }
            //second string
            else if(i>=amountOfFrets&&i<2*amountOfFrets){
                startingHeight=[[startingHeights objectAtIndex:(i-amountOfFrets)] floatValue];
                if(i-amountOfFrets==0){
                    heightOfButton=180;
                }
                else{
                    nextStartingHeight=[[startingHeights objectAtIndex:(i-amountOfFrets+1)] floatValue];
                    heightOfButton= nextStartingHeight-startingHeight;
                }
                [button setFrame:CGRectMake(width/amountOfStrings, startingHeight, width/amountOfStrings, heightOfButton)];
                [buttonsOfString1 addObject:button];

            }
            //third string
            else if(i>=2*amountOfFrets&&i<3*amountOfFrets){
                startingHeight=[[startingHeights objectAtIndex:(i-2*amountOfFrets)] floatValue];
                if(i-2*amountOfFrets==0){
                    heightOfButton=180;
                }
                else{
                    nextStartingHeight=[[startingHeights objectAtIndex:(i-2*amountOfFrets+1)] floatValue];
                    heightOfButton= nextStartingHeight-startingHeight;
                }
                [button setFrame:CGRectMake(2*width/amountOfStrings, startingHeight, width/amountOfStrings, heightOfButton)];
                [buttonsOfString2 addObject:button];
            }
        
            //fourth string
            else if(i>=3*amountOfFrets&&i<4*amountOfFrets) {
                startingHeight=[[startingHeights objectAtIndex:(i-3*amountOfFrets)] floatValue];
                if(i-3*amountOfFrets==0){
                    heightOfButton=180;
                }
                else{
                    nextStartingHeight=[[startingHeights objectAtIndex:(i-3*amountOfFrets+1)] floatValue];
                    heightOfButton= nextStartingHeight-startingHeight;
                }
                [button setFrame:CGRectMake(3*width/amountOfStrings, startingHeight, width/amountOfStrings, heightOfButton)];
                [buttonsOfString3 addObject:button];
            }
        
        //fifth string
            else if(i>=4*amountOfFrets&&i<5*amountOfFrets) {
                startingHeight=[[startingHeights objectAtIndex:(i-4*amountOfFrets)] floatValue];
                if(i-4*amountOfFrets==0){
                    heightOfButton=180;
                }
                else{
                    nextStartingHeight=[[startingHeights objectAtIndex:(i-4*amountOfFrets+1)] floatValue];
                    heightOfButton= nextStartingHeight-startingHeight;
                }
                [button setFrame:CGRectMake(4*width/amountOfStrings, startingHeight, width/amountOfStrings, heightOfButton)];
                [buttonsOfString4 addObject:button];
            }
        
        //sixth string
            else if(i>=5*amountOfFrets&&i<6*amountOfFrets) {
                startingHeight=[[startingHeights objectAtIndex:(i-5*amountOfFrets)] floatValue];
                if(i-5*amountOfFrets==0){
                    heightOfButton=180;
                }
                else{
                    nextStartingHeight=[[startingHeights objectAtIndex:(i-5*amountOfFrets+1)] floatValue];
                    heightOfButton= nextStartingHeight-startingHeight;
                }
                [button setFrame:CGRectMake(5*width/amountOfStrings, startingHeight, width/amountOfStrings, heightOfButton)];
                [buttonsOfString5 addObject:button];
            }


        [self.view addSubview:button];

//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(width/(2*amountOfStrings), 0, 1, scrollViewHeight)];
//        lineView.backgroundColor = [UIColor blackColor];
//        [self.view addSubview:lineView];
        

    };
    //Draw strings, frets and circles
    CAShapeLayer *stringLayer = [CAShapeLayer layer];
    CAShapeLayer *fretLayer = [CAShapeLayer layer];
    CAShapeLayer *circleLayer = [CAShapeLayer layer];

    //Create a path to draw the strings and the frets
    UIBezierPath *stringPath = [UIBezierPath bezierPath];
    UIBezierPath *fretPath = [UIBezierPath bezierPath];
    UIBezierPath *circlePath=[UIBezierPath bezierPath];
    
    for(int i=0; i<amountOfStrings; i++)
    {
        [stringPath moveToPoint:CGPointMake((i+1)*width/(amountOfStrings)-width/(2*amountOfStrings), 0)];
        [stringPath addLineToPoint:CGPointMake((i+1)*width/(amountOfStrings)-width/(2*amountOfStrings), scrollViewHeight)];
        stringLayer.path = [stringPath CGPath];
        stringLayer.strokeColor = [[UIColor blackColor] CGColor];
        stringLayer.lineWidth = 3/(0.5*i+1);
        stringLayer.fillColor = [[UIColor clearColor] CGColor];
        
    }
    [self.view.layer addSublayer:stringLayer];
    
    //draw frets
    for(int i=0; i<amountOfFrets+1; i++)
    {
        NSInteger startingHeight = [startingHeights[i] integerValue];
        [fretPath moveToPoint:CGPointMake(0, startingHeight)];
        [fretPath addLineToPoint:CGPointMake(width, startingHeight)];
        fretLayer.path = [fretPath CGPath];
        fretLayer.strokeColor = [[UIColor blackColor] CGColor];
        fretLayer.lineWidth = 3;
        fretLayer.fillColor = [[UIColor clearColor] CGColor];
    }
    [self.view.layer addSublayer:fretLayer];

    //Draw circles between frets
    for(int i=2; i<12; i=i+2)
    {
        NSInteger startingHeight = [startingHeights[i] integerValue];
        NSInteger previousStartingHeight = [startingHeights[i-1] integerValue];
        circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, startingHeight+(startingHeight-previousStartingHeight)/2)
                                                             radius:10
                                                         startAngle:0
                                                           endAngle:360
                                                          clockwise:YES];
        circleLayer.path = [circlePath CGPath];
    }

    [self.view.layer addSublayer:circleLayer];
    
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
   // NSString *toneToPlay =[NSString stringWithFormat:@"TONE%d",tag];
    sender.backgroundColor= [UIColor grayColor];
    NSLog(@"buttonDown: %d",tag);
    sender.selected=TRUE;
}

//... and when they are released
- (IBAction)buttonUp:(UIButton *)sender {
    sender.backgroundColor= [UIColor whiteColor];
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
            for (int i=buttonsOfString0.count-1; i>=0; i--) {
                // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[buttonsOfString0 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    baseToneShouldPlay=FALSE;
                    [[OALSimpleAudio sharedInstance] playEffect:tonesOfString0[i+1]];
                    return;
                }
            }
            if(baseToneShouldPlay){
                [[OALSimpleAudio sharedInstance] playEffect:tonesOfString0[0]];

            }
            
        }
        
        else if([stringNumber isEqual:@"<01>"]){
            NSLog(@"string 1 played");
            for (int i=buttonsOfString1.count-1; i>=0; i--) {
                // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[buttonsOfString1 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    NSLog(@"i: %d",i);
                    baseToneShouldPlay=FALSE;
                    [[OALSimpleAudio sharedInstance] playEffect:tonesOfString1[i+1]];
                    return;
                }
            }
            if(baseToneShouldPlay){
                NSLog(@"basetone Should play");
                [[OALSimpleAudio sharedInstance] playEffect:tonesOfString1[0]];
                
            }
            
        }
        
        else if([stringNumber isEqual:@"<02>"]){
            NSLog(@"string 2 played");
            for (int i=buttonsOfString2.count-1; i>=0; i--) {
               // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[buttonsOfString2 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    baseToneShouldPlay=FALSE;
                    [[OALSimpleAudio sharedInstance] playEffect:tonesOfString2[i+1]];
                    return;
                }
            }
            if(baseToneShouldPlay){
                [[OALSimpleAudio sharedInstance] playEffect:tonesOfString2[0]];

            }
            
        }
        else if([stringNumber isEqual:@"<03>"]){
            NSLog(@"string 3 played");
            for (int i=buttonsOfString3.count-1; i>=0; i--) {
                // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[buttonsOfString3 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    baseToneShouldPlay=FALSE;
                    [[OALSimpleAudio sharedInstance] playEffect:tonesOfString3[i+1]];
                    return;
                    
                }
            }
            if(baseToneShouldPlay){
                if(baseToneShouldPlay){
                    [[OALSimpleAudio sharedInstance] playEffect:tonesOfString3[0]];
                
            }
        }
    
    }
        else if([stringNumber isEqual:@"<04>"]){
            NSLog(@"string 4 played");
            for (int i=buttonsOfString4.count-1; i>=0; i--) {
                // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[buttonsOfString4 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    baseToneShouldPlay=FALSE;
                    [[OALSimpleAudio sharedInstance] playEffect:tonesOfString4[i+1]];
                    return;
                    
                }
            }
            if(baseToneShouldPlay){
                if(baseToneShouldPlay){
                    [[OALSimpleAudio sharedInstance] playEffect:tonesOfString4[0]];
                    
                }
            }
            
        }
        else if([stringNumber isEqual:@"<05>"]){
            NSLog(@"string 5 played");
            for (int i=buttonsOfString5.count-1; i>=0; i--) {
                // NSLog(@"object from array %@", [testString2 objectAtIndex:i]);
                UIButton *buttonOnString=[buttonsOfString5 objectAtIndex:i];
                if(buttonOnString.selected ==TRUE){
                    baseToneShouldPlay=FALSE;
                    [[OALSimpleAudio sharedInstance] playEffect:tonesOfString5[i+1]];
                    return;
                    
                }
            }
            if(baseToneShouldPlay){
                if(baseToneShouldPlay){
                    [[OALSimpleAudio sharedInstance] playEffect:tonesOfString5[0]];
                    
                }
            }
            
        }
        //rotary encoder has been turned clockwise
        else if([stringNumber isEqual:@"<ff>"]){
            NSLog(@"incoming data from rotary encoder:  %@",stringNumber);
            verticalPosition=verticalPosition+10;
        }
        //rotary encoder has been turned counter clockwise
        else if([stringNumber isEqual:@"<11>"]){
            NSLog(@"incoming data from rotary encoder:  %@",stringNumber);
            if(verticalPosition>0){
                verticalPosition=verticalPosition-10;
            }
            else{
                verticalPosition=0;
            }
        }
        NSLog(@"vertical position %d", verticalPosition);
        [scrollView setContentOffset:CGPointMake(0, verticalPosition) animated:NO];

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

