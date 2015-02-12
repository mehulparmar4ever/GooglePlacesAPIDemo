//
//  HomeViewController.m
//  Demo_Mehul
//
//  Created by Apple-PC on 12/15/14.
//  Copyright (c) 2014 Openxcell. All rights reserved.
//

#import "HomeViewController.h"
#import "CELL_Custom.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "FTGooglePlacesAPI.h"
#import "FTGooglePlacesAPIExampleDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"

typedef NS_ENUM(NSUInteger, FTGooglePlacesAPIExampleType) {
    FTGooglePlacesAPIExampleTypeMuseumKeyword,
};

@interface HomeViewController ()
{

}
@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinate;
@property (nonatomic, strong) id<FTGooglePlacesAPIRequest> initialRequest;
@property (nonatomic, strong) id<FTGooglePlacesAPIRequest> actualRequest;
@property (nonatomic, strong) CLLocation *searchLocation;
@property (nonatomic, strong) FTGooglePlacesAPISearchResponse *lastResponse;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) NSMutableArray *results;
@end

@implementation HomeViewController

@synthesize tblMain;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Nearby Places";
    
    // Custom initialization
    //Here i have Set Custom Location
    self.locationCoordinate = CLLocationCoordinate2DMake(23.0370544,72.5142021);
    
    //Clear Data
    _results = [NSMutableArray array];
    
    _searchLocation = [[CLLocation alloc] initWithLatitude:self.locationCoordinate.latitude longitude:self.locationCoordinate.longitude];
    
    //Set Activity Indicator
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.hidesWhenStopped = YES;
    
    UIBarButtonItem *activityBarButton = [[UIBarButtonItem alloc] initWithCustomView:_activityIndicatorView];
    self.navigationItem.rightBarButtonItem = activityBarButton;
    
    //Create Request to Get Data from Google Places
    id<FTGooglePlacesAPIRequest> request = [self googlePlacesAPIRequestForExampleType:FTGooglePlacesAPIExampleTypeMuseumKeyword];

    _initialRequest = request;
    _actualRequest = request;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //  Controller is first displayed - start searching
    if ([_results count] == 0) {
        [self startSearching];
    }
}

#pragma mark - FTGooglePlacesAPI performing search request

- (void)startSearching
{
    //  Show activity indicator
    [_activityIndicatorView startAnimating];
    
    //  Execute Google Places API request using FTGooglePlacesAPIService
    [FTGooglePlacesAPIService executeSearchRequest:_actualRequest
                             withCompletionHandler:^(FTGooglePlacesAPISearchResponse *response, NSError *error)
     {
         //  If error is not nil, request failed and you should handle the error
         //  We just show alert
         if (error)
         {
             //  There may be a lot of causes for an error (for example networking error).
             //  If the network communication with Google Places API was successfull,
             //  but the API returned some status code, NSError will have
             //  FTGooglePlacesAPIErrorDomain domain and status code from
             //  FTGooglePlacesAPIResponseStatus enum
             //  You can inspect error's domain and status code for more detailed info
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription] message:[error localizedFailureReason] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             [_activityIndicatorView stopAnimating];
             return;
         }
         
         //  Everything went fine, we have response object
         //  You can do whatever you need here, we just add new items to the
         //  data source array and reload the table
         //  You could add new rows with animation etc., but it would add useless
         //  complexity to the sample code app
         
         //  Update last response object
         _lastResponse = response;
         
         //  Add new results to the data source array
         [_results addObjectsFromArray:response.results];
         
         //         NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
         
         
         
         //These Distance Code may be useful to SORT in Future....
         for (int i=0; i<[_results count]; i++)
         {
             //  Get response object
             FTGooglePlacesAPISearchResultItem *resultItem = _results[i];
             
             if (resultItem.location) {
                 CLLocationDistance distance = [resultItem.location distanceFromLocation:_searchLocation];
                 NSString *strdistance = [NSString stringWithFormat:@"Distance: %.0fm", distance];
                 NSLog(@"strdistance=%@",strdistance);
                 resultItem.strDistance=strdistance;
             }
         }
         
         [self.tblMain reloadData];
         
         [_activityIndicatorView stopAnimating];
     }];
}

- (id<FTGooglePlacesAPIRequest>)googlePlacesAPIRequestForExampleType:(FTGooglePlacesAPIExampleType)type
{
    id<FTGooglePlacesAPIRequest> result;
    
    switch (type)
    {
        case FTGooglePlacesAPIExampleTypeMuseumKeyword:
        {
            FTGooglePlacesAPINearbySearchRequest *request = [[FTGooglePlacesAPINearbySearchRequest alloc] initWithLocationCoordinate:self.locationCoordinate];
            //  may be useful in future
            //  FTGooglePlacesAPITextSearchRequest *request = [[FTGooglePlacesAPITextSearchRequest alloc] initWithQuery:@"pizza in london"];
            
            //Diff types of sort in Google Places
            //  request.keyword = @"museum";
            //  request.openNow = YES;
            //  request.types = @[@"art_gallery", @"museum"];
            //  request.types = @[@"restaurant"];
            //  request.minPrice = 4;
            
            request.radius = 500;
            result = request;
        }
            break;
    }
    return result;
}

#pragma mark Table view Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return ArrList.count;    //count number of row from counting array hear cataGorry is An Array
    return [_results count] + ([_lastResponse hasNextPage]);

}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Load More Cell
    static NSString *LoadMoreCellIdentifier = @"LoadMoreCell";
    //Custom Design Cell
    static NSString *ResultCellIdentifier = @"CELL_Custom";

    BOOL isLoadMoreResultsCell = [self isLoadMoreResultsCellAtIndexPath:indexPath];
    NSString *cellIdentifier = (isLoadMoreResultsCell? LoadMoreCellIdentifier:ResultCellIdentifier);
    
    // Using Custom Cell
    CELL_Custom *cell=(CELL_Custom *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //  Configure "Load more" cell
    if (isLoadMoreResultsCell)
    {
        //  This is constant cell, so we can preconfigure it on the init
        if (cell==nil)
        {
            NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"CELL_Custom"
                                                        owner:self options:nil];
            cell=[nibs objectAtIndex:0];
        }
        
        cell.Lbl_Name.textAlignment = NSTextAlignmentCenter;
        cell.Lbl_Name.text = @"Load more results...";
        [cell.Lbl_Name setFrame:CGRectMake(cell.Lbl_Name.frame.origin.x-70, cell.Lbl_Name.frame.origin.y, cell.Lbl_Name.frame.size.width+70, cell.Lbl_Name.frame.size.height)];
        [cell.Lbl_Name setFont:[UIFont boldSystemFontOfSize:30]];
        [cell.Img_thumb setHidden:YES];
        [cell.Lbl_sec setHidden:YES];
        return cell;
    }
    else   //  Configure "CELL_Custom" cell
    {
        if (cell==nil)
        {
            NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"CELL_Custom"
                                                        owner:self options:nil];
            cell=[nibs objectAtIndex:0];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        [cell.Img_thumb setHidden:NO];
        [cell.Lbl_sec setHidden:NO];
        cell.Img_thumb.layer.cornerRadius = 10;
        cell.Img_thumb.layer.masksToBounds = YES;
        
        //  Get response object
        FTGooglePlacesAPISearchResultItem *resultItem = _results[indexPath.row];
        
        cell.Lbl_Name.text=resultItem.name;
        
        NSLog(@"resultItem.strDistance=%@",resultItem.strDistance);
        if (resultItem.location) {
            CLLocationDistance distance = [resultItem.location distanceFromLocation:_searchLocation];
            cell.Lbl_sec.text = [NSString stringWithFormat:@"Distance: %.0fm", distance];
        }
        
        //if temp Set Icon to Image
        [cell.Img_thumb setImageWithURL:[NSURL URLWithString:resultItem.iconImageUrl] placeholderImage:[self placeholderImage]];
        
        //If Place found Photos
        if(resultItem.photos !=nil)
        {
            NSArray *aryPhotos = resultItem.photos;
            NSString *photoreference =[NSString stringWithFormat:@"%@",[[aryPhotos objectAtIndex:0] valueForKey:@"photo_reference"]];
            
            //Save Temp in SDImageCache
            if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:photoreference])
            {
                cell.Img_thumb.image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:photoreference];
            }
            else
            {
                NSString *strPlace=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=%@&key=%@",photoreference,@"AIzaSyA1B4sNPcKPf76dcgLgYsJzCVP79NRTUKI"];
                NSURL *URL = [NSURL URLWithString:strPlace];
                NSURLRequest *request = [NSURLRequest requestWithURL:URL];
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                 {
                     UIImage *img=[UIImage imageWithData:data];
                     
                     [[SDImageCache sharedImageCache] storeImage:img forKey:photoreference];
                     cell.Img_thumb.image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:photoreference];
                 }];
            }
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //  Selected "Load more results" cell
    if ([self isLoadMoreResultsCellAtIndexPath:indexPath])
    {
        //  Get request for a new page of results and start search
        id<FTGooglePlacesAPIRequest> nextPageRequest = [_lastResponse nextPageRequest];
        _actualRequest = nextPageRequest;
        [self startSearching];
    }
    //  Selected result item cell
    else
    {
        //  Get response object
        FTGooglePlacesAPISearchResultItem *resultItem = _results[indexPath.row];
        
        //  Create detail request
        FTGooglePlacesAPIDetailRequest *request = [[FTGooglePlacesAPIDetailRequest alloc] initWithPlaceId:resultItem.placeId];
        
        //  Create detail controller
        FTGooglePlacesAPIExampleDetailViewController *detailController = [[FTGooglePlacesAPIExampleDetailViewController alloc] initWithRequest:request];
        
        [self.navigationController pushViewController:detailController animated:YES];
        
        //  And print it to the console
        NSLog(@"Selected item: %@", resultItem);
    }
}

- (UIImage *)placeholderImage
{
    static UIImage *PlaceholderImage;
    
    if (!PlaceholderImage)
    {
        CGRect rect = CGRectMake(0, 0, 40.0f, 40.0f);
        
        UIGraphicsBeginImageContext(rect.size);
        [[UIColor whiteColor] setFill];
        [[UIBezierPath bezierPathWithRect:rect] fill];
        PlaceholderImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return PlaceholderImage;
}

#pragma mark - LoadMore methods

- (BOOL)isLoadMoreResultsCellAtIndexPath:(NSIndexPath *)indexPath
{
    //  It is load more cell if there is more results to read and this is
    //  the last cell in a table view
    NSInteger numberOfRows = [self tableView:self.tblMain numberOfRowsInSection:indexPath.section];
    return ((indexPath.row == numberOfRows - 1) && [_lastResponse hasNextPage]);
}

@end
