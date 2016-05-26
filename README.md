# ios-failable
Either monad to simplify data in completion blocks

Heavily influenced by [Fallible](https://gist.github.com/brentdax/f9ed95550ea0afac9505) by [brentdax](https://github.com/brentdax) and [Result](https://github.com/Alamofire/Alamofire/blob/master/Source/Result.swift) of [Alamofire](https://github.com/Alamofire/Alamofire). Failable data is generic and can return item(s) or if failed an optional ErrorType. 

## Requirements

- iOS 8.0+ / Mac OS X 10.9+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 7.3+

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8 or OS X Mavericks (10.9).**

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required.

To integrate Failable into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'Failable', '~> 0.2.0'
```

Then, run the following command:

```bash
$ pod install
```

### Example Usage

```swift
func example(completion: ((data: Failable<String>) -> Void)?) {
    completion?(data: .Success("hello"))
}

example { (data) in
	if let value = data.value {
		print(value)
	}
}

```
