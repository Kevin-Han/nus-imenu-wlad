//
//  NUSMenuDetailViewController.m
//  iMenu
//
//  Created by Song Lei on 30/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSMenuDetailViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface NUSMenuDetailViewController ()
- (void)shareToFriends;
- (void)shareBySMS;
- (void)shareByEmail;
@end

@implementation NUSMenuDetailViewController
@synthesize caloriesLable = _caloriesLable;
@synthesize dietaryFiberLable = _dietaryFiberLable;
@synthesize sugarsLable = _sugarsLable;
@synthesize totalFatLable = _totalFatLable;
@synthesize totalCarbohydrateLable = _totalCarbohydrateLable;
@synthesize amountServingSizeLable = _amountServingSizeLable;

@synthesize photoUIImageView=_photoUIImageView, dataItem=_dataItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [_dataItem objectForKey:@"Name"];
    
    //UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(shareToFriends)];
    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareToFriends)];
    
    self.navigationItem.rightBarButtonItem = shareBarButton;
    
    [_photoUIImageView setImage:[UIImage imageNamed:[_dataItem objectForKey:@"Image"]]];
    
    [_caloriesLable setText:[_dataItem objectForKey:@"Calories"]];
    [_dietaryFiberLable setText:[_dataItem objectForKey:@"Dietary Fiber"]];
    [_sugarsLable setText:[_dataItem objectForKey:@"Sugars"]];
    [_totalFatLable setText:[_dataItem objectForKey:@"Total Fat"]];
    [_totalCarbohydrateLable setText:[_dataItem objectForKey:@"Total Carbohydrate"]];
    [_amountServingSizeLable setText:[_dataItem objectForKey:@"Amount Serving Size"]];
    
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPhotoUIImageView:nil];

    [self setCaloriesLable:nil];
    [self setDietaryFiberLable:nil];
    [self setSugarsLable:nil];
    [self setTotalFatLable:nil];
    [self setTotalCarbohydrateLable:nil];
    [self setAmountServingSizeLable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) 
    {
        case 0:
            [self shareByEmail];
            break;
        
        case 1:
            [self shareBySMS];
            break;
            
        default:
            break;
    }
}


#pragma mark - Private

- (void)shareToFriends
{
    UIActionSheet *sharSheet = [[UIActionSheet alloc] initWithTitle:@"Shar to friends" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share by Email", @"Share by SMS", nil];
	sharSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[sharSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)shareByEmail
{
    NSLog(@"%s", __FUNCTION__);
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = (id)self;
        
        [mailer setSubject:@"Here is the good deal at Burger Queen."];
        
        // NSArray *toRecipients = [NSArray arrayWithObjects:@"fisrtMail@example.com", @"secondMail@example.com", nil;
        // [mailer setToRecipients:toRecipients];
        
        // UIImage *myImage = [UIImage imageNamed:@"icon.png"];
        //  UIImage *myImage = [UIImage imageNamed:[_dataItem objectForKey:@"Image"]];
        //UIImage *myImage = [_dataItem objectForKey:@"Image"];
        //  NSData *imageData = UIImagePNGRepresentation(myImage);
        // [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];	
        
        
        NSString *emailBody = @"<html><head></head><body><table><tr><td colspan=\"2\">";
        emailBody = [emailBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Name"]];
        emailBody = [emailBody stringByAppendingString:@"</td></tr><tr><td>Price:</td><td>"];
        emailBody = [emailBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Price"]];
        emailBody = [emailBody stringByAppendingString:@"</td></tr><tr><td>Calories</td><td>"];
        emailBody = [emailBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Calories"]];
        emailBody = [emailBody stringByAppendingString:@"</td></tr><tr><td>Dietary Fiber</td><td>"];
        emailBody = [emailBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Dietary Fiber"]];
        emailBody = [emailBody stringByAppendingString:@"</td></tr><tr><td>Sugars</td><td>"];
        emailBody = [emailBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Sugars"]];
        emailBody = [emailBody stringByAppendingString:@"</td></tr><tr><td>Total Fats</td><td>"];
        emailBody = [emailBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Total Fats"]];
        emailBody = [emailBody stringByAppendingString:@"</td></tr><tr><td>Total Carbohydrate</td><td>"];
        emailBody = [emailBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Total Carbohydrate"]];
        emailBody = [emailBody stringByAppendingString:@"</td></tr><tr><td>Amount Serving Size</td><td>"];
        emailBody = [emailBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Amount Serving Size"]];
        emailBody = [emailBody stringByAppendingString:@"</table></body></html>"];
        
        [mailer setMessageBody:emailBody isHTML:YES];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
        
        //[mailer release];
    }
    else
    {
        [self printMessage:@"cannot SendMail"];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void)shareBySMS
{
   // MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
     MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
        NSString *smsBody = @"Here's the good deal at Burger Queen. ";
        smsBody = [smsBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Name"]];
        smsBody = [smsBody stringByAppendingString:@" $"];
        smsBody = [smsBody stringByAppendingFormat:@"%@", [_dataItem objectForKey:@"Price"]];

		controller.body = smsBody;
		controller.messageComposeDelegate = (id)self;
		[self presentModalViewController:controller animated:YES];
	}
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
            NSLog(@"SMS Failed");
			break;
		case MessageComposeResultSent:
            NSLog(@"SMS Sent");
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

-(void) printMessage:(NSString *)name{
    UIAlertView *alertPopUp=[[UIAlertView alloc]
                             initWithTitle:@"Alert"
                             message:name 
                             delegate:nil 
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alertPopUp show];
    NSLog(@"The message is %@",name);
}

@end
