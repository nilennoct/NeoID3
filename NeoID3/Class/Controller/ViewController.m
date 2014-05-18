//
//  ViewController.m
//  NeoID3
//
//  Created by Neo on 15/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (id) init {
	if (self = [super init]) {
		self.ac = [AudioController getInstance];
	}
	
	return self;
}

- (IBAction)openFiles:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setAllowsMultipleSelection:YES];
	[panel setCanChooseDirectories:NO];
	[panel setAllowedFileTypes:self.ac.allowedFileTypes];

	[panel beginSheetModalForWindow:self.mainWindow completionHandler:^(NSInteger result) {
		if (result == NSFileHandlingPanelOKButton) {
			NSArray *urls = [panel URLs];
			
			NSProgressIndicator *progressIndicator = [self progressIndicator];
			[progressIndicator setIndeterminate:YES];
			[progressIndicator startAnimation:self];
			
			for (NSURL *url in urls) {
				TagLibWrapper *wrapper = [TagLibWrapper wrapperWithPath:[url path]];
				if ([self.ac.audios indexOfObject:wrapper] == NSNotFound) {
					[wrapper readFile];
					[self.arrayController addObject:wrapper];
				}
			}
			
			[progressIndicator stopAnimation:self];
		}
	}];
}

- (IBAction)openFolders:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setAllowsMultipleSelection:YES];
	[panel setCanChooseDirectories:YES];
	[panel setCanChooseFiles:NO];
	
	[panel beginSheetModalForWindow:self.mainWindow completionHandler:^(NSInteger result) {
		if (result == NSFileHandlingPanelOKButton) {
			NSArray *urls = [panel URLs];
			NSArray *allowedFileTypes = self.ac.allowedFileTypes;
			NSFileManager *fileMngr = [NSFileManager defaultManager];
			
			NSProgressIndicator *progressIndicator = [self progressIndicator];
			[progressIndicator setIndeterminate:YES];
			[progressIndicator startAnimation:self];
			
			for (NSURL *url in urls) {
				NSString *path = [url path];
				NSDirectoryEnumerator *dirEnumerator = [fileMngr enumeratorAtPath:path];
				NSString *filename;
				while (filename = [dirEnumerator nextObject]) {
					if ([allowedFileTypes containsObject:[filename pathExtension]]) {
						TagLibWrapper *wrapper = [TagLibWrapper wrapperWithPath:[NSString stringWithFormat:@"%@/%@", path, filename]];
						if ([self.ac.audios indexOfObject:wrapper] == NSNotFound) {
							[wrapper readFile];
							[self.arrayController addObject:wrapper];
						}
					}
				}
			}
			
			[progressIndicator stopAnimation:self];
		}
	}];
}

- (IBAction)removeFiles:(id)sender {
	if ([self.audioTable numberOfSelectedRows] == 0) {
		return;
	}
	
	NSIndexSet *selectedIndexes = [self.audioTable selectedRowIndexes];
	[self.arrayController removeObjectsAtArrangedObjectIndexes:selectedIndexes];
	[self.audioTable deselectAll:self];
}

- (IBAction)saveFiles:(id)sender {
	NSIndexSet *selectedIndexes = [self.audioTable selectedRowIndexes];
	if ([selectedIndexes count] == 0) {
		return;
	}
	
	NSArray *selectedAudios = [[self.arrayController arrangedObjects] objectsAtIndexes:selectedIndexes];
	
	NSProgressIndicator *progressIndicator = [self progressIndicator];
	[progressIndicator setIndeterminate:NO];
	[progressIndicator setDoubleValue:0];
	[progressIndicator setMaxValue:[selectedAudios count]];

	for (TagLibWrapper *wrapper in selectedAudios) {
		[wrapper saveTags];
		NSLog(@"%@ saved.", [wrapper title]);
		[self.arrayController removeObject:wrapper];
		[progressIndicator incrementBy:1];
	}
	
	[self.audioTable deselectAll:self];
}

- (IBAction)clearFiles:(id)sender {
	[self.arrayController removeObjects:[self.arrayController arrangedObjects]];
}

- (IBAction)showHelp:(id)sender {
	NSURL *url = [NSURL URLWithString:@"http://www.nilennoct.com"];
	[[NSWorkspace sharedWorkspace] openURL:url];
}

- (void)editTags {
	NSInteger selectedIndex = [self.audioTable selectedRow];
	if (selectedIndex != -1) {
		self.selectedWrapper = [[self.ac audios] objectAtIndex:selectedIndex];
		if ( ! [self.editorPanel isVisible]) {
			[self.editorPanel makeKeyAndOrderFront:self];
		}
	}
}

@end
