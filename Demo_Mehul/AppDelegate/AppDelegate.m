//
//  AppDelegate.m
//  Demo_Mehul
//
//  Created by Apple-PC on 12/15/14.
//  Copyright (c) 2014 Openxcell. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "FTGooglePlacesAPI.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    //Change StatusBarColor
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
#warning Possible incomplete implementation. Make sure you add you own Google Places API key
    
    [FTGooglePlacesAPIService provideAPIKey:@"AIzaSyA1B4sNPcKPf76dcgLgYsJzCVP79NRTUKI"];

    cllMngr = [[CLLocationManager alloc]init];
    cllMngr.delegate=self;
    cllMngr.desiredAccuracy=500;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
#ifdef __IPHONE_8_0
        [cllMngr requestAlwaysAuthorization];
#endif
    }
    [cllMngr startUpdatingLocation];
    
    // Override point for customization after application launch.
    HomeViewController *home =[[HomeViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:home];
    self.window.rootViewController=nav;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
