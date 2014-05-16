//
//  TagLibWrapper.m
//  NeoID3
//
//  Created by Neo on 14/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "TagLibWrapper.h"

@interface TagLibWrapper ()

@end

@implementation TagLibWrapper

@synthesize encoding = _encoding;

+ (id) wrapperWithPath:(NSString *)path {
	return [[self alloc] initWithPath:path];
}

- (id) initWithPath:(NSString *)path {
	if (self = [super init]) {
		filepath = path;
		file = new TagLib::FileRef([filepath UTF8String]);
		tag = file->tag();
		
		originEncoding = self.encoding = [self detectEncoding];
		[self loadTags];
	}
	
	return self;
}

- (void) dealloc {
	delete file;
}

- (NSString *) detectEncoding {
	TagLib::String title = tag->title();
	TagLib::String artist = tag->artist();
	TagLib::String album = tag->album();
	
	TagLib::String detectString = title + title + title + artist + artist + artist + album + album;
	
	Boolean isUTF8 = !detectString.isNull() && !detectString.isEmpty() && !detectString.isAscii() && !detectString.isLatin1();
	
	uchardet_t ud = uchardet_new();
	uchardet_handle_data(ud, detectString.toCString(isUTF8), detectString.length());
	uchardet_data_end(ud);
	
	const char *charset = uchardet_get_charset(ud);
	NSString *encodingString = [NSString stringWithCString:charset encoding:NSASCIIStringEncoding];
	
	uchardet_delete(ud);
//	NSLog(@"%@", encodingString);
	
	return encodingString;
}

- (void) loadTags {
	NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding((CFStringRef)self.encoding));
	//		NSLog(@"%lu, %u", (unsigned long)encoding, NSUTF8StringEncoding);
	if (encoding == NSUTF8StringEncoding) {
		self.title = [NSString stringWithUTF8String:tag->title().toCString(true)];
		self.album = [NSString stringWithUTF8String:tag->album().toCString(true)];
		self.artist = [NSString stringWithUTF8String:tag->artist().toCString(true)];
		self.genre = [NSString stringWithUTF8String:tag->genre().toCString(true)];
		self.comment = [NSString stringWithUTF8String:tag->comment().toCString(true)];
	}
	else {
		self.title = [NSString stringWithCString:tag->title().toCString() encoding:encoding];
		self.album = [NSString stringWithCString:tag->album().toCString() encoding:encoding];
		self.artist = [NSString stringWithCString:tag->artist().toCString() encoding:encoding];
		self.genre = [NSString stringWithCString:tag->genre().toCString() encoding:encoding];
		self.comment = [NSString stringWithCString:tag->comment().toCString() encoding:encoding];
	}
	self.year = [NSNumber numberWithInt:tag->year()];
	self.track = [NSNumber numberWithInt:tag->track()];
}

- (void) saveTags:(BOOL)forceSave {
	if (forceSave || [originEncoding isEqualToString:self.encoding]) {
		tag->setTitle(TagLib::String([self.title UTF8String], TagLib::String::UTF8));
		tag->setArtist(TagLib::String([self.artist UTF8String], TagLib::String::UTF8));
		tag->setAlbum(TagLib::String([self.album UTF8String], TagLib::String::UTF8));
		tag->setGenre(TagLib::String([self.genre UTF8String], TagLib::String::UTF8));
		tag->setComment(TagLib::String([self.comment UTF8String], TagLib::String::UTF8));
		tag->setYear([self.year intValue]);
		tag->setTrack([self.track intValue]);
		
		file->save();
	}
}

- (NSString *) filepath {
	return  filepath;
}

- (NSString *) encoding {
	@synchronized (self) {
		return _encoding;
	}
}

- (void) setEncoding:(NSString *)encoding {
	@synchronized (self) {
		if ( ! [self.encoding isEqualToString:encoding]) {
			_encoding = encoding;
			[self loadTags];
		}
	}
}

@end
