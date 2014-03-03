//
//  MainViewController.h
//  TestApp
//
//  Created by WebInfoways on 03/03/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomCell.h"

@interface MainViewController : UIViewController <UITextFieldDelegate>
{
    int intNumberSelection;     //1=No of Rooms, 2=No of Adults, 3=Age of Adult
    BOOL bolIsRoomSelection;
    int intNoOfRooms;
    
    int cellSection;
    int cellRow;
    
    NSMutableIndexSet *expandedSections;
}
@property (nonatomic, retain) NSMutableArray *arrNumber;

@property (nonatomic, retain) IBOutlet UIButton *btnDateFrom;
@property (nonatomic, retain) IBOutlet UIButton *btnDateTo;
@property (nonatomic, retain) IBOutlet UIButton *btnNoOfRooms;

@property (nonatomic, retain) IBOutlet UIView *viewDate;
@property (nonatomic, retain) IBOutlet UIView *viewNumber;

@property (nonatomic, retain) IBOutlet UIDatePicker *pickerDate;
@property (nonatomic, retain) IBOutlet UIButton *btnDateDone;

@property (nonatomic, retain) IBOutlet UIPickerView *pickerNumber;
@property (nonatomic, retain) IBOutlet UIButton *btnNumberDone;

@property(nonatomic,retain) IBOutlet UITableView *tblRoomDetails;
@property(nonatomic,retain) NSMutableDictionary *dictRoomDetails;

-(IBAction)btnTappedDateSelect:(id)sender;
-(IBAction)btnTappedDateDone:(id)sender;

-(IBAction)btnTappedNoOfRoomsSelect:(id)sender;
-(IBAction)btnTappedNumberDone:(id)sender;


@end
