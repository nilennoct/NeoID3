//
//  TagLibWrapper.h
//  NeoID3
//
//  Created by Neo on 14/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iconv.h>
#import <uchardet/uchardet.h>
#import <taglib/fileref.h>
#import <taglib/tag.h>
using namespace TagLib;

@interface TagLibWrapper : NSObject {
	FileRef *file;
	Tag *tag;
	NSString *filepath;
	NSString *originEncoding;
}

@property (nonatomic) NSString *encoding;
@property (retain) NSString *title;
@property (retain) NSString *artist;
@property (retain) NSString *album;
@property (retain) NSString *genre;
@property (retain) NSNumber *year;
@property (retain) NSNumber *track;
@property (retain) NSString *comment;

+ (id) wrapperWithPath:(NSString *)path;

- (id) initWithPath:(NSString *)path;

- (NSString *) detectEncoding;

- (void) loadTags;
- (void) saveTags:(BOOL)forceSave;

- (NSString *) filepath;

- (void) setEncoding:(NSString *)encoding;

@end
