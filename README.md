# SwiftyImageCache
Helper framework to cache image with url in Swift iOS.

## Requirements

* iOS 8.0+
* Xcode 8+
* Swift 3

## Installation

### CocoaPods

To integrate PhotoCollectionView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'SwiftyImageCache', '~> 1.0'
```

Then, run the following command:

```bash
$ pod install
```

### Manually
- Drag and drop `Sources` folder into your project.

## Usage

### ImageCache
Use `ImageCache` object to cache your image from URL

```
	let cache = ImageCache()
	cache.loadImage(atUrl: url, completion: { (urlString, image) in
	})
```
or use `default` cache
```
	ImageCache.default.loadImage(atUrl: url, completion: { (urlString, image) in
	})
```
### CacheType
You can config `cacheType` 
```
	ImageCache.default.cacheType = .disk // (default mode, recommendation)
	ImageCache.default.cacheType = .ram
```

## License
[MIT](http://thi.mit-license.org/)