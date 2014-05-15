//
//  ViewController.m
//  NeoID3
//
//  Created by Neo on 15/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize ac;

- (id) init {
	if (self = [super init]) {
		ac = [AudioController getInstance];
	}
	
	return self;
}

- (IBAction)openFiles:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setAllowsMultipleSelection:YES];
	[panel setCanChooseDirectories:NO];
	[panel setAllowedFileTypes:[NSArray arrayWithObjects:@"mp3", @"aac", nil]];
	
	[panel beginWithCompletionHandler:^(NSInteger result) {
		if (result == NSFileHandlingPanelOKButton) {
			NSArray *urls = [panel URLs];
			
			NSProgressIndicator *progressIndicator = [self progressIndicator];
			[progressIndicator setIndeterminate:YES];
			[progressIndicator startAnimation:self];
			
			for (NSURL *url in urls) {
				TagLibWrapper *wrapper = [TagLibWrapper wrapperWithPath:[url path]];
				[[self arrayController] addObject:wrapper];
//				sleep(1);
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
	
	[panel beginWithCompletionHandler:^(NSInteger result) {
		if (result == NSFileHandlingPanelOKButton) {
			NSArray *urls = [panel URLs];
			NSArray *allowedFileTypes = [NSArray arrayWithObjects:@"mp3", @"aac", nil];
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
						[[self arrayController] addObject:wrapper];
					}
				}
			}
			
			[progressIndicator stopAnimation:self];
		}
	}];
}

- (IBAction)removeFiles:(id)sender {
	NSIndexSet *selectedAudios = [[self audioTable] selectedRowIndexes];
	
	if ([selectedAudios count] == 0) {
		return;
	}
	
	[[self arrayController] removeObjectsAtArrangedObjectIndexes:selectedAudios];
}

- (IBAction)saveFiles:(id)sender {
	NSMutableArray *audios = [[self arrayController] arrangedObjects];
	
	NSProgressIndicator *progressIndicator = [self progressIndicator];
	[progressIndicator setIndeterminate:NO];
	[progressIndicator setDoubleValue:0];
	[progressIndicator setMaxValue:[audios count]];
//	[progressIndicator startAnimation:self];
	int i = 0;
	for (TagLibWrapper *wrapper in audios) {
//		[wrapper saveTags:YES];
		NSLog(@"%@ saved.%d", [wrapper title], i++);
//		sleep(1);
		[[self arrayController] removeObject:wrapper];
		[progressIndicator incrementBy:1];
	}
}

- (IBAction)testAction:(id)sender {
	NSArray *seleted = [[self arrayController] selectedObjects];
	if ([seleted count] == 0) {
		return;
	}
	
	if ([[seleted[0] encoding] isEqualToString:@"UTF-8"]) {
		[seleted[0] setEncoding:@"gb18030"];
	}
	else {
		[seleted[0] setEncoding:@"UTF-8"];
	}
//	[self arrayController] 
}

@end
