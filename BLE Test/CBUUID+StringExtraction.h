//
//  CBUUID+StringExtraction.h
//  Bluefruit Connect
//
//  Created by Adafruit Industries on 2/21/14.
//  Copyright (c) 2014 Adafruit Industries. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@interface CBUUID (StringExtraction)

- (NSString *)representativeString;

@end
