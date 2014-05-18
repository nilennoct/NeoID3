//
//  TagLibWrapper.m
//  NeoID3
//
//  Created by Neo on 14/5/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "TagLibWrapper.h"

@implementation TagLibWrapper

@synthesize encoding = _encoding;

+ (id) wrapperWithPath:(NSString *)path {
	return [[self alloc] initWithPath:path];
}

- (id) initWithPath:(NSString *)path {
	if (self = [super init]) {
		self.filepath = path;
		file = nil;
	}
	
	return self;
}

- (void) dealloc {
	if (file != nil) {
		delete file;
	}
}

- (BOOL)isEqual:(id)object {
	if ([super isEqual:object]) {
		return YES;
	}
	else {
		return [self.filepath isEqualToString:[(TagLibWrapper *)object filepath]];
	}
}

- (NSString *) detectEncoding {
	TagLib::String title = tag->title();
	TagLib::String artist = tag->artist();
	TagLib::String album = tag->album();
	TagLib::String genre = tag->genre();
	TagLib::String comment = tag->comment();
	
	TagLib::String detectString = title + title + title + artist + artist + artist + album + album + genre + comment;
	
	bool isUTF8 = ! detectString.isNull() && ! detectString.isEmpty() && ! detectString.isAscii() && ! detectString.isLatin1();
	
	uchardet_t ud = uchardet_new();
	NSString *encodingString = nil;
	BOOL detectResult = 0 == uchardet_handle_data(ud, detectString.toCString(isUTF8), detectString.length());
	
	uchardet_data_end(ud);
	if (detectResult) {
		encodingString = [[NSString stringWithCString:uchardet_get_charset(ud) encoding:NSASCIIStringEncoding] uppercaseString];
	}
	uchardet_delete(ud);
	
	if (encodingString == nil || [encodingString length] == 0) {
		encodingString = @"UTF-8";
	}
//	NSLog(@"%@", encodingString);
	
	return encodingString;
}

- (void) readFile {
	file = new TagLib::FileRef([self.filepath UTF8String]);
	tag = file->tag();
	
	originEncoding = self.encoding = [self detectEncoding];
	[self loadTags];
	self.edited = false;
}

- (void) loadTags {
	BOOL edited = self.edited;
	NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding((CFStringRef)self.encoding));

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
	
	self.edited = edited;
}

- (void) saveTags:(BOOL)forceSave {
	if (forceSave || ! [originEncoding isEqualToString:self.encoding] || self.edited) {
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
- (void)saveTags {
	[self saveTags:NO];
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

- (void)setTitle:(NSString *)title {
	if ([self.title isEqualToString:title]) {
		return;
	}
	_title = title != nil ? title : @"";
	self.edited = YES;
}

- (void)setArtist:(NSString *)artist {
	if ([self.artist isEqualToString:artist]) {
		return;
	}
	_artist = artist != nil ? artist : @"";
	self.edited = YES;
}

- (void)setAlbum:(NSString *)album {
	if ([self.album isEqualToString:album]) {
		return;
	}
	_album = album != nil ? album : @"";
	self.edited = YES;
}

- (void)setTrack:(NSNumber *)track {
	if (self.track == track) {
		return;
	}
	_track = track;
	self.edited = YES;
}

- (void)setYear:(NSNumber *)year {
	if (self.year == year) {
		return;
	}
	_year = year;
	self.edited = YES;
}

- (void)setComment:(NSString *)comment {
	if ([self.comment isEqualToString:comment]) {
		return;
	}
	_comment = comment != nil ? comment : @"";
	self.edited = YES;
}

@end
