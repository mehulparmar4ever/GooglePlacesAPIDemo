
//#define WSURL @"http://192.168.1.13/mysinglecity/ws/"

#define WSURL @"http://54.165.122.78/ws/" //@"http://stylekart.net/2014/msc/ws/"

#define PrivacyPolicyURL @"http://54.165.122.78/page/privacy" //@"http://stylekart.net/2014/msc/page/privacy"

#define TermsURL @"http://54.165.122.78/page/terms" //http://stylekart.net/2014/msc/page/terms

#define launchImagePath @"http://54.165.122.78/admin/img/ic_launcher.png" //@"http://stylekart.net/2014/msc/admin/img/ic_launcher.png"

#define Payment_status @"http://54.165.122.78/ws/user/user_payment_status"

#define InternetError @"You must connect to the internet to use this app. Please check internet connectivity settings"
#define WSResultFalse @"Communication error"
#define NoDataFound @"No data found"
#define AlertTitle @"MySingleCity"

#define wXAPIKEY @"6d9f729b765aae27f45e5ef9150fa073f8a61b94"

#define METERS_PER_MILE 1609.344


static inline void showAlertView(NSString *aStrAlertMsg)
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AlertTitle message:aStrAlertMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

static inline BOOL isEmpty(id thing)
{
    if (thing == nil)
    {
        return YES;
    }
    else if ([thing isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if ([thing isKindOfClass:[NSData class]])
    {
        if ([(NSData *)thing length] == 0)
        {
            return YES;
        }
    }
    else if ([thing isKindOfClass:[NSArray class]])
    {
        if ([(NSArray *)thing copy] == 0)
        {
            return YES;
        }
    }
    else if ([thing isKindOfClass:[NSString class]])
    {
        if ([[(NSString *)thing stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
        {
            return YES;
        }
    }
    return NO;
}