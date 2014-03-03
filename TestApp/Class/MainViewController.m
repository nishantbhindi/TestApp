//
//  MainViewController.m
//  TestApp
//
//  Created by WebInfoways on 03/03/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
    
    _arrNumber = [[NSMutableArray alloc] init];
    for(int i=1;i<=100;i++)
        [_arrNumber addObject:[NSString stringWithFormat:@"%d",i]];
        
    
    [_viewDate setFrame:CGRectMake(_viewDate.frame.origin.x, 378.0, _viewDate.frame.size.width, _viewDate.frame.size.height)];
    [_viewNumber setFrame:CGRectMake(_viewNumber.frame.origin.x, 378.0, _viewNumber.frame.size.width, _viewNumber.frame.size.height)];
    
    [self.view addSubview:_viewDate];
    [self.view addSubview:_viewNumber];
    
    [_viewDate setHidden:TRUE];
    [_viewNumber setHidden:TRUE];
}

#pragma mark - Date Selection
-(IBAction)btnTappedDateSelect:(id)sender{
    [_btnDateDone setTag:[sender tag]];
    
    [_viewDate setHidden:FALSE];
    [_viewNumber setHidden:TRUE];
}
-(IBAction)btnTappedDateDone:(id)sender{
    if([sender tag]==1)
        [_btnDateFrom setTitle:[[_pickerDate date] description] forState:UIControlStateNormal];
    else
        [_btnDateTo setTitle:[[_pickerDate date] description] forState:UIControlStateNormal];
    
    [_viewDate setHidden:TRUE];
    [_viewNumber setHidden:TRUE];
}

#pragma mark - Number Selection
-(IBAction)btnTappedNoOfRoomsSelect:(id)sender{
    intNumberSelection = 1;
    [_btnNumberDone setTag:[sender tag]];
    
    [_viewDate setHidden:TRUE];
    [_viewNumber setHidden:FALSE];
}
-(IBAction)btnTappedNumberDone:(id)sender{
    [_viewDate setHidden:TRUE];
    [_viewNumber setHidden:TRUE];
    
    int intSelectedRow = [_pickerNumber selectedRowInComponent:0];
    
    if(intNumberSelection==1){
        intNoOfRooms = [[_arrNumber objectAtIndex:intSelectedRow] intValue];
        
        [_btnNoOfRooms setTitle:[NSString stringWithFormat:@"%d",intNoOfRooms] forState:UIControlStateNormal];
        [self createRoomDetails];
    }
    else if(intNumberSelection==2){
        int intNoOfAdults = [[_arrNumber objectAtIndex:intSelectedRow] intValue];
        
        NSMutableDictionary *dicObj = [_dictRoomDetails objectForKey:[NSString stringWithFormat:@"%d",[sender tag]]];
        [dicObj setObject:[NSString stringWithFormat:@"%d", intNoOfAdults] forKey:@"TotalAdults"];
        
        NSMutableDictionary *dicAdultDetails = [[NSMutableDictionary alloc] init];
        for(int i=0;i<intNoOfAdults;i++)
        {
            NSMutableDictionary *dicAdult = [[NSMutableDictionary alloc] init];
            [dicObj setObject:@"" forKey:@"AdultName"];
            [dicObj setObject:@"0" forKey:@"AdultAge"];
            [dicAdultDetails setObject:dicAdult forKey:[NSString stringWithFormat:@"%d",i]];
        }
        [dicObj setObject:dicAdultDetails forKey:@"AdultsDetails"];
    }
    else if(intNumberSelection==3){
        int intAgeOfAdult = [[_arrNumber objectAtIndex:intSelectedRow] intValue];
        
        /*
        NSMutableDictionary *dicObj = [_dictRoomDetails objectForKey:[NSString stringWithFormat:@"%d",[sender tag]]];
        NSMutableDictionary *dicAdultDetails = [dicObj objectForKey:@"AdultsDetails"];
        NSMutableDictionary *dicAdult = [dicAdultDetails objectForKey:[NSString stringWithFormat:@"%d",[sender tag]]];
         */
        
        NSMutableDictionary *dicObj = [_dictRoomDetails objectForKey:[NSString stringWithFormat:@"%d",cellSection]];
        NSMutableDictionary *dicAdultDetails = [dicObj objectForKey:@"AdultsDetails"];
        NSMutableDictionary *dicAdult = [dicAdultDetails objectForKey:[NSString stringWithFormat:@"%d",[sender tag]]];
        
        [dicAdult setObject:[NSString stringWithFormat:@"%d", intAgeOfAdult] forKey:@"AdultAge"];
    }
    
    [_tblRoomDetails reloadData];
}

#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _arrNumber.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _arrNumber[row];
}
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    /*
    if(intNumberSelection==1){
        [_btnNoOfRooms setTitle:[_arrNumber objectAtIndex:row] forState:UIControlStateNormal];
        
        intNoOfRooms = [[_arrNumber objectAtIndex:row] intValue];
        [self createRoomDetails];
    }
    else{
    }
     */
}
#pragma mark - Create Room Details
-(void)createRoomDetails
{
    _dictRoomDetails = [[NSMutableDictionary alloc]initWithCapacity:intNoOfRooms];
    for(int i=0;i<intNoOfRooms;i++)
    {
        NSMutableDictionary *dicAdultDetails = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary *dicObj = [[NSMutableDictionary alloc] init];
        [dicObj setObject:@"0" forKey:@"TotalAdults"];
        [dicObj setObject:dicAdultDetails forKey:@"AdultsDetails"];
        
        [_dictRoomDetails setObject:dicObj forKey:[NSString stringWithFormat:@"%d",i]];
    }
}

#pragma mark - TableView DataSource and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return intNoOfRooms;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableDictionary *dicObj = [_dictRoomDetails objectForKey:[NSString stringWithFormat:@"%d",section]];
    int intAdultForRoom = [[dicObj objectForKey:@"TotalAdults"] intValue];
    return intAdultForRoom;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *objView =[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)];
    [objView setBackgroundColor:[UIColor grayColor]];
    
    UILabel *lblTitle = [[UILabel alloc] init];
    [lblTitle setText:[NSString stringWithFormat:@"Adult for Room-%d:", section+1]];
    [lblTitle setFrame:CGRectMake(10.0, 0.0, 200.0, 30.0)];
    [objView addSubview:lblTitle];
    [lblTitle release];
    
    NSMutableDictionary *dicObj = [_dictRoomDetails objectForKey:[NSString stringWithFormat:@"%d",section]];
    int intAdultForRoom = [[dicObj objectForKey:@"TotalAdults"] intValue];
    
    UIButton *btnSelectAdult=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnSelectAdult setFrame:CGRectMake(220.0, 0.0, 90.0, 30.0)];
    [btnSelectAdult setTitle:[NSString stringWithFormat:@"%d", intAdultForRoom] forState:UIControlStateNormal];
    [btnSelectAdult setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnSelectAdult setTag:section];
    [btnSelectAdult addTarget:self action:@selector(btnTappedNoOfAdults:) forControlEvents:UIControlEventTouchDown];
    [objView addSubview:btnSelectAdult];
    
    return objView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    RoomCell *cell = (RoomCell *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    
    if(cell==nil || ![cell isKindOfClass:[RoomCell class]])
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"RoomCell"
                                            owner:self options:nil];
        
        for (id oneObject in nib) if ([oneObject isKindOfClass:[RoomCell class]])
            cell = (RoomCell *)oneObject;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    
    NSMutableDictionary *dicObj = [_dictRoomDetails objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]];
    NSMutableDictionary *dicAdultDetails = [dicObj objectForKey:@"AdultsDetails"];
    NSMutableDictionary *dicAdult = [dicAdultDetails objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    
    int intAdultAge = [[dicAdult objectForKey:@"AdultAge"] intValue];
    
    [cell.txtName setTag:indexPath.row];
    [cell.txtName setDelegate:self];
    
    [cell.btnAge setTitle:[NSString stringWithFormat:@"%d", intAdultAge] forState:UIControlStateNormal];
    [cell.btnAge setTag:indexPath.row];
    [cell.btnAge addTarget:self action: @selector(buttonPressed:withEvent:) forControlEvents: UIControlEventTouchUpInside];
    //[cell.btnAge addTarget:self action:@selector(btnTappedAge:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CustomCellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    */
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark Section Tapped
- (void)btnTappedSection:(UIButton*)btn {
    BOOL currentlyExpanded = [expandedSections containsIndex:btn.tag];
    if (currentlyExpanded)
    {
        [expandedSections removeIndex:btn.tag];
        [_tblRoomDetails reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        [expandedSections addIndex:btn.tag];
        [_tblRoomDetails reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma mark No of Adults Tapped
- (void)btnTappedNoOfAdults:(UIButton*)btn {
    intNumberSelection = 2;
    [_btnNumberDone setTag:[btn tag]];
    
    [_viewDate setHidden:TRUE];
    [_viewNumber setHidden:FALSE];
}
#pragma mark Age Tapped
- (void)btnTappedAge:(UIButton*)btn {
    intNumberSelection = 3;
    [_btnNumberDone setTag:[btn tag]];
    
    [_viewDate setHidden:TRUE];
    [_viewNumber setHidden:FALSE];
}
- (void)buttonPressed:(id)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:_tblRoomDetails];
    NSIndexPath *indexPath = [_tblRoomDetails indexPathForRowAtPoint: location];
    
    cellSection = indexPath.section;
    cellRow = indexPath.row;
    
    intNumberSelection = 3;
    [_btnNumberDone setTag:indexPath.row];
    
    [_viewDate setHidden:TRUE];
    [_viewNumber setHidden:FALSE];
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
