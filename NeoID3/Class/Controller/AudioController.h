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

@interface AudioController : NSArrayController

@property NSMutableArray *audios;
@property (readonly) NSArray *allowedEncodings;
@property (readonly) NSArray *allowedFileTypes;

+ (AudioController *) getInstance;

- (id) init;

- (void) openAudio:(NSString *) path;


@end
