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

@interface TagLibWrapper : NSObject {
	TagLib::FileRef *file;
	TagLib::Tag *tag;
	NSString *originEncoding;
}

@property (retain) NSString *filepath;

@property (retain) NSString *encoding;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *artist;
@property (retain, nonatomic) NSString *album;
@property (retain, nonatomic) NSString *genre;
@property (retain, nonatomic) NSNumber *year;
@property (retain, nonatomic) NSNumber *track;
@property (retain, nonatomic) NSString *comment;

@property BOOL edited;

+ (id) wrapperWithPath:(NSString *)path;

- (id) initWithPath:(NSString *)path;

- (NSString *) detectEncoding;

- (void) readFile;
- (void) loadTags;
- (void) saveTags:(BOOL)forceSave;
- (void) saveTags;

- (void) setEncoding:(NSString *)encoding;

@end
