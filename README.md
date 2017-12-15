# SwiftyImageCache

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7efc2255a0924d64a45f5a4dabaedcd9)](https://www.codacy.com/app/noblakit01/SwiftyImageCache?utm_source=github.com&utm_medium=referral&utm_content=noblakit01/SwiftyImageCache&utm_campaign=badger)

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

pod 'SwiftyImageCache', '~> 1.2.1'
```

Then, run the following command:

```bash
$ pod install
```

### Manually
- Drag and drop `Sources` folder into your project.

## Usage

### Convenient UIImageView
Set url to imageview. 
```swift
imageView.setUrl(url)
```
Design for `UITableView`/`UICollectionView` asynchronous image. Only need `setUrl` from any `UIImageView` in `UITableViewCell`/`UICollectionViewCell`.

### ImageCache
Use `ImageCache` object to cache your image from URL

```swift
	let cache = ImageCache()
	cache.loadImage(atUrl: url, completion: { (urlString, image) in
	})
```
or use `default` cache
```swift
	ImageCache.default.loadImage(atUrl: url, completion: { (urlString, image) in
	})
```
### CacheType
You can config `cacheType` 
```swift
	ImageCache.default.cacheType = .disk // (default mode, recommendation)
	ImageCache.default.cacheType = .ram
```

## TODO
[Todo](https://github.com/noblakit01/SwiftyImageCache/blob/master/TODO.md)

## License
[MIT](http://thi.mit-license.org/)
