//
//  MediaController.m
//  NeoID3
//
//  Created by Neo on 14/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "AudioController.h"

@implementation AudioController

//@synthesize audios;
//@synthesize allowedEncodings;

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
		self.allowedEncodings = [NSArray arrayWithObjects:@"UTF-8", @"gb18030", nil];
	}
	
	return self;
}

- (void) openAudio:(NSString *)path {
	TagLibWrapper *tagLibWrapper = [[TagLibWrapper alloc] initWithPath:path];
	NSLog(@"Title: %@, Album: %@", [tagLibWrapper title], [tagLibWrapper album]);
}

@end
