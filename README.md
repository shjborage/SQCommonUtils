SQCommonUtils
=============

Common Utils SDK for ObjC project which Requires iOS 4.0 and later.

###Relase Note:

**V0.3.0**

1. Full update for code style;
2. Add more useful feature.
3. Support this in other 'SDK'.

**V0.2.1**

1. ARC support
2. Fix some warnning

V0.2.0

1. Add UIView+SQFrame support.
2. Add SQCommonHeader.h to load all the Utils.
3. Fix some bugs.

V0.1

1.	Not Support ARC
2.	Requires iOS 4.0 and later.

###Brief

####UIView+SQFrame
*	Use `self.view.originX`, so easy and you can use this `self.view.originX = 0.0f`.

####SQStringUtils
*	Encode / Decode
*	Use as fileName
*	time format usage

####SQDebugUtils
*	`SQLog` for custom NSLog and enable/disable marco.
*	Easy to get current class name, function name and so on.
*	`SQTestManager` show used memory and times
*	`SQTestManager` can rewrite all logs to file by time.

####SQColorUtils

*	`RGB` for create UIColor from RGB Value.
*	`[someColor createImage]` for create an image.

####SQGlobalMarco.h
*	isPhone5, isPad
*	kOSVersion
*	other

###Installing

####CocoaPods
CocoaPods automates 3rd party dependencies in Objective-C.

#####Install the ruby gem.

```
$ sudo gem install cocoapods
$ pod setup
```

Depending on your Ruby installation, you may not have to run as sudo to install the cocoapods gem. Create a Podfile. You must be running on iOS 5 or above.

```
platform :ios, '5.0'
pod 'SQCommonUtils', '0.1'
```

Install dependencies.

```
$ pod install
```

When using CocoaPods, you must open the .xcworkspace file instead of the project file when building your project.

###License

The MIT License (MIT)

Copyright (c) 2013 Eric

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.