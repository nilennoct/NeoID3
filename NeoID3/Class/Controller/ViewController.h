//
//  ViewController.h
//  NeoID3
//
//  Created by Neo on 15/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioController.h"

@interface ViewController : NSViewController {
//	AudioController *ac;
//	TagLibWrapper *selectedWrapper;
}

@property AudioController *ac;
@property TagLibWrapper *selectedWrapper;

@property (weak) IBOutlet NSTableView *audioTable;
@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet NSArrayController *arrayController;
@property (unsafe_unretained) IBOutlet NSPanel *editorPanel;

- (id) init;

- (IBAction)openFiles:(id)sender;
- (IBAction)openFolders:(id)sender;
- (IBAction)removeFiles:(id)sender;
- (IBAction)saveFiles:(id)sender;
- (IBAction)testAction:(id)sender;

- (void)editTags;

@end
