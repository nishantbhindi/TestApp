//
//  AppDelegate.h
//  TestApp
//
//  Created by WebInfoways on 03/03/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (nonatomic, retain) UINavigationController *navController;
@property (strong, nonatomic) MainViewController *viewController;

@end
