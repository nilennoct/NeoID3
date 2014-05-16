//
//  MediaController.h
//  NeoID3
//
//  Created by Neo on 14/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "TagLibWrapper.h"

@interface AudioController : NSArrayController {
//	NSMutableArray *audios;
//	NSArray *allowedEncodings;
}

@property NSMutableArray *audios;
@property NSArray *allowedEncodings;

+ (AudioController *) getInstance;

- (id) init;

- (void) openAudio:(NSString *) path;


@end
