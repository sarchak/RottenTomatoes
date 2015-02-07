//
//  AppDelegate.m
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/2/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "AppDelegate.h"
#import "MoviesListViewController.h"
#import "CollectionViewController.h"
#import "ParentViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MoviesListViewController *vc = [[MoviesListViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];



    /* Main controller */
    CollectionViewController *cvc = [[CollectionViewController alloc] init];
    UINavigationController *ncvc = [[UINavigationController alloc] initWithRootViewController:cvc];
    ParentViewController *pvc = [[ParentViewController alloc] init];
    UINavigationController *npvc = [[UINavigationController alloc] initWithRootViewController:pvc];
    UITabBarController *tbc = [[UITabBarController alloc] init];
    [tbc setViewControllers:@[nvc,ncvc]];
//    [tbc setViewControllers:@[nvc,npvc]];

    NSArray *items = tbc.tabBar.items;
    
    UITabBarItem *movies = [items objectAtIndex:0];
    UITabBarItem *dvds = [items objectAtIndex:1];
    [movies initWithTitle:@"Movies" image:[UIImage imageNamed:@"Movies"] selectedImage: [UIImage imageNamed:@"Movies"]];
    
    [dvds initWithTitle:@"DVDs" image:[UIImage imageNamed:@"DVDs"] selectedImage: [UIImage imageNamed:@"DVDs"]];
    
    self.window.rootViewController= tbc;
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:[UIColor colorWithRed:8.0/255 green:10.0/255 blue:15.0/255 alpha:1]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:206.0/255 blue:112.0/255 alpha:1.0]}];

    [navBar setTintColor:[UIColor colorWithRed:1.0 green:206.0/255 blue:112.0/255 alpha:1.0]];

    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBarTintColor:[UIColor colorWithRed:8.0/255 green:10.0/255 blue:15.0/255 alpha:1]];
    
    [tabBar setTintColor:[UIColor colorWithRed:1.0 green:206.0/255 blue:112.0/255 alpha:1.0]];


    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
