SQCommonUtils
=============

Common Utils SDK for ObjC project.

V0.1

1.	Not Support ARC
2.	Requires iOS 4.0 and later.

###Brief

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