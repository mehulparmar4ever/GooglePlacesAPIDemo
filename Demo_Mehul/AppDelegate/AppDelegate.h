//
//  AppDelegate.h
//  Demo_Mehul
//
//  Created by Apple-PC on 12/15/14.
//  Copyright (c) 2014 Openxcell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

{
    // Variables
    CLLocationManager *cllMngr;
    //Outlets

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *strLattitudeG;
@property (strong, nonatomic) NSString *strLongitudeG;

@end
