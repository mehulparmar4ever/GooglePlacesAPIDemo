#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define NavBar                              self.navigationController.navigationBar
#define TabBar                              self.tabBarController.tabBar
#define NavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewWidth                       self.view.bounds.size.width
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define FlushPool(p)                        [p drain]; p = [[NSAutoreleasePool alloc] init]
#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0];


//Font

#define GOTHAMTHIN(fontsize)                 [UIFont fontWithName:@"Gotham Thin" size:fontsize]
#define GOTHAMMEDIUM(fontsize)               [UIFont fontWithName:@"Gotham Medium" size:fontsize]
#define GOTHAMLIGHT(fontsize)                  [UIFont fontWithName:@"Gotham Light" size:fontsize]
#define GOTHAMREGULAR(fontsize)              [UIFont fontWithName:@"Gotham Book" size:fontsize]



#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) objectAtIndex:0]

//For setting static images for iPhone 4 and iPhone 5
#define ASSET_BY_SCREEN_HEIGHT(regular, longScreen) (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? regular : longScreen)

//For Checking device is iPhone 4 or iPhone 5
#define isIphone5() (([[UIScreen mainScreen] bounds].size.height  <= 480.0) ? 0 : 1)

#define IS_DEVICE_iPHONE_5 ((UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) && ([[UIScreen mainScreen ] bounds].size.height == 568.0))

#define IS_DEVICE_iPHONE_6 ((UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) && ([[UIScreen mainScreen ] bounds].size.height == 667.0))
#define IS_DEVICE_iPHONE_6Plus ((UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) && ([[UIScreen mainScreen ] bounds].size.height ==736.0f))

#define IS_DEVICE_iPHONE_6And6Plus ((UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) && ([[UIScreen mainScreen ] bounds].size.height >=667.0))

#define IS_IOS7_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)


#define isIpad() (([[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPad) ? 1 : 0)


//Check System Version

#define SYSTEM_VERSION_EQUAL_TO(v)         ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)        ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//Step:1
//To stop print NSLog write this code
/*
#define __DEBUG__

#ifdef __DEBUG__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif
*/
//Step:2
//and When don't want logs in app then just comment the first line i.e

#define __DEBUG__




#define userSessionDict [[NSUserDefaults standardUserDefaults] objectForKey:@"session"]
#define DeviceToken [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"]
#define XAPIKEY [[NSUserDefaults standardUserDefaults] objectForKey:@"X-API-KEY"]

#define LoginFlag [[NSUserDefaults standardUserDefaults] boolForKey:@"LoginFlag"]
#define LoginName [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"]
#define LoginPassword [[NSUserDefaults standardUserDefaults] objectForKey:@"UserPassword"]

#define ISPremiumVersion [[NSUserDefaults standardUserDefaults] boolForKey:@"isPaid"]
#define ISFacebookShareOn [[NSUserDefaults standardUserDefaults] boolForKey:@"facebookShare"]

#define ISDonotAskMeClicked [[NSUserDefaults standardUserDefaults] boolForKey:@"tick"]

#define ISNotificationUpdateOn [[NSUserDefaults standardUserDefaults] boolForKey:@"notificationUpdate"]
#define ISPasswordChange [[NSUserDefaults standardUserDefaults] boolForKey:@"passwordChange"]

#define MyDate [[NSUserDefaults standardUserDefaults] objectForKey:@"aDate"]

#define Country [[NSUserDefaults standardUserDefaults] objectForKey:@"country"]



#define BoolSetting(param) [[NSUserDefaults standardUserDefaults] boolForKey:(param)]
#define IntSetting(param) [[NSUserDefaults standardUserDefaults] integerForKey:(param)]

// Setting screen Push Notification
#define SignUpFirstTime @"SignUpfirstTime"



