//
//  BLEMainViewController.h
//  Adafruit Bluefruit LE Connect
//
//  Copyright (c) 2013 Adafruit Industries. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "UARTPeripheral.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface BLEMainViewController : UIViewController <UINavigationControllerDelegate, CBCentralManagerDelegate, UARTPeripheralDelegate, AVAudioPlayerDelegate, UIScrollViewDelegate>
{
    UIScrollView *scrollView;
}
typedef enum {
    ConnectionModeNone  = 0,
    ConnectionModePinIO,
    ConnectionModeUART,
} ConnectionMode;

typedef enum {
    ConnectionStatusDisconnected = 0,
    ConnectionStatusScanning,
    ConnectionStatusConnected,
} ConnectionStatus;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) IBOutlet UISlider *volumeControl;

@property (nonatomic, assign) ConnectionMode                    connectionMode;
@property (nonatomic, assign) ConnectionStatus                  connectionStatus;

@end

//@implementation BLEMainViewController
//- (void)drawRect:(CGRect)rect{
  //  CGRect rectangle = CGRectMake(0, 100, 320, 100);
   // CGContextRef context = UIGraphicsGetCurrentContext();
  //  CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
  //  CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
  //  CGContextFillRect(context, rectangle);
//}
//@end