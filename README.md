# NeoID3

## About

NeoID3 is a simple Mac app used to convert MP3 tags encoding to UTF-8.

> ID3 is a metadata container most often used in conjunction with the MP3 audio file format. It allows information such as the title, artist, album, track number, and other information about the file to be stored in the file itself.

> From [Wikipedia](http://en.wikipedia.org/wiki/ID3 "ID3").

In ID3v2, tags can be stored in several encodings, such as ISO-8859-1 and UTF-8, while the media palyers in common use, like iTunes and Vox, can only read tags encoded in UTF-8.

## Feature
 
 - Detect encoding automatically (powered by [uchardet](https://code.google.com/p/uchardet/ "uchardet"));
 - Convert multiple files;
 - Edit MP3 ID3 tag.

## Support encodings

- UTF-8
- GB18030
- BIG5
- SHIFT_JIS
- EUC-KR

## Build

To build this project, you need install TagLib and uchardet at first.

	# use homebrew
	brew install taglib uchardet
	
Tested on Mac OS X 10.9.3 & Xcode 5.1.1.
 
## Notice
 
This app uses [TagLib](http://taglib.github.io "TagLib") to read and write ID3 tags. After converting, the MP3 file's tag would be updated to ID3v2.4. Please check whether your media player supports ID3v2.4 before converting.

For example, if you would enjoy your music both in Mac OS and in Windows, you should notice the fact below:

> Windows Explorer and Windows Media Player cannot handle ID3v2.4 tags in any version, up to and including Windows 8 / Windows Media Player 12. Windows can understand ID3v2 up to and including version 2.3.[\[1\]][1][\[2\]][2]

---

## 关于

NeoID3 是一个轻量级的 Mac 应用，用于将 MP3 文件的 ID3 标签转换为 UTF-8 编码。

> ID3是一种metadata容器，多应用于MP3格式的音频文件中。它可以将相关的曲名、演唱者、专辑、音轨数等信息存储在MP3文件中。

> 引用自 [维基百科](http://en.wikipedia.org/wiki/ID3 "ID3").

ID3v2的标签可使用多种不同的编码，比如 ISO-8859-1、UTF-8等。然而像 iTunes、Vox 等多数常用的媒体播放器只支持读取 UTF-8 格式的标签，因此在 Mac 平台上打开来自 Windows 平台的 MP3 文件时经常会出现乱码。NeoID3 主要就是为了解决这一问题而产生的。

## 功能
 
 - 自动检测标签编码 (由 [uchardet](https://code.google.com/p/uchardet/ "uchardet") 提供支持)；
 - 批量转换；
 - 编辑 MP3 ID3 标签。

## 支持编码

- UTF-8
- GB18030
- BIG5
- SHIFT_JIS
- EUC-KR

## 生成（Build）

若要生成此工程，请确保已安装 TagLib 和 uchardet。（谁能告诉我 Build 到底译成什么比较好？构建？生成？编译&连接？囧）

	# 使用 homebrew
	brew install taglib uchardet
	
Mac OS X 10.9.3 & Xcode 5.1.1 测试通过。
 
## 注意
 
NeoID3使用 [TagLib](http://taglib.github.io "TagLib") 读取和写入 ID3 标签，因此转换后会将 MP3 文件的 ID3 标签更新为 ID3v2.4 版本。请在转换前确定你使用的播放器是否支持 ID3v2.4，因此产生的问题本人概不负责。

如果你同时使用 Mac OS X 和 Windows，并在 Windows 中使用 Windows Media Player 管理、播放 MP3 文件，请不要使用本软件。

> 任何版本的Windows Explorer 和 Windows Media Player 都无法处理 ID3v2.4 标签, 包括 Windows 8 / Windows Media Player 12. Windows 最高支持到 ID3v2.3.[\[1\]][1][\[2\]][2]

[1]: http://arstechnica.com/features/2012/10/a-work-in-progress-the-windows-8-multimedia-experience/2/ "Music and Video in Windows 8: a work in progress"
 
[2]: http://answers.microsoft.com/en-us/windows/forum/windows_7-pictures/how-to-add-id3v24-support-for-windows-7-64bit/a9427521-eb6f-4fe4-affb-f61532846503 "Microsoft support community"
