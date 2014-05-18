//
//  MediaController.m
//  NeoID3
//
//  Created by Neo on 14/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "AudioController.h"

@implementation AudioController

+ (AudioController *) getInstance {
	static AudioController *singleton = nil;
	
	@synchronized(self) {
		if (singleton == nil) {
			singleton = [[AudioController alloc] init];
		}
		
		return singleton;
	}
}

- (id) init {
	if (self = [super init]) {
		self.audios = [NSMutableArray arrayWithCapacity:10];
		
		_allowedEncodings = [NSArray arrayWithObjects:@"UTF-8", @"GB18030", @"BIG5", @"SHIFT_JIS", @"EUC-KR", nil];
		_allowedFileTypes = [NSArray arrayWithObjects:@"mp3", nil];
	}
	
	return self;
}

- (void) openAudio:(NSString *)path {
	TagLibWrapper *tagLibWrapper = [[TagLibWrapper alloc] initWithPath:path];
	NSLog(@"Title: %@, Album: %@", [tagLibWrapper title], [tagLibWrapper album]);
}

@end
