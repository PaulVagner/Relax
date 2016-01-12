# Encodable

Swiftly Encode & Decode for Archiving & JSON

<!-- [![CI Status](http://img.shields.io/travis/Jo Albright/Encodable.svg?style=flat)](https://travis-ci.org/Jo Albright/Encodable) -->

[![Version](https://img.shields.io/cocoapods/v/Encodable.svg?style=flat)](http://cocoapods.org/pods/Encodable)
[![License](https://img.shields.io/cocoapods/l/Encodable.svg?style=flat)](http://cocoapods.org/pods/Encodable)
[![Platform](https://img.shields.io/cocoapods/p/Encodable.svg?style=flat)](http://cocoapods.org/pods/Encodable)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
struct Person: Encodable {
    
    var name: String?
    var age: Int = 0
    
    init() { }
    
    init(_ info: EncodedInfo) {
        
        name <-- info["name"]
        age <-- info["age"]
        
    }

}
```

**Struct from Example project**

```swift
struct Album: Encodable {
    
    var title: String?
    var artist: String?
    var albumImageURL: String?
    var albumImage: UIImage?
    var trackCount: Int?
    var collectionPrice: Double?
    
    init() { }
    
    init(_ info: EncodedInfo) {
        
        title <-- info["collectionName"]
        artist <-- info["artistName"]
        albumImageURL <-- info["artworkUrl100"]
        trackCount <-- info["trackCount"]
        collectionPrice <-- info["collectionPrice"]
        
    }
    
}
```

## Requirements

This pod uses [Inlinit](https://github.com/joalbright/Inlinit) (a pod that allows closure initalizers). 

## Installation

Encodable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Encodable"
```

Encodable is also available through [Swift Package Manager](https://swift.org/package-manager/). Please take a look at the link to learn more about how to use SwiftPM.

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PACKAGE_NAME",
    dependencies: [
        .Package(url: "https://github.com/joalbright/Encodable.git", majorVersion: 0)
    ]
)
```

## Author

[Jo Albright](https://github.com/joalbright)

## License

Encodable is available under the MIT license. See the LICENSE file for more info.
