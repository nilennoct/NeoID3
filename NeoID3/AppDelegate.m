//
//  AppDelegate.m
//  NeoID3
//
//  Created by Neo on 14/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	ViewController *vc = [[ViewController alloc] init];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

@end
