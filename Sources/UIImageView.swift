//
//  UIImageView.swift
//  SwiftyImageCache
//
//  Created by Minh Luan Tran on 8/4/17.
//
//

import UIKit

let _swiftUrlKey = malloc(4)

extension UIImageView {
    public func setUrl(_ url: URL, qualityFactor: CGFloat? = nil, cache: ImageCache = .default, completion: ((UIImage?) -> Void)? = nil) {
        let fitSize = qualityFactor != nil ? bounds.size * qualityFactor! : nil
        swiftUrlKey = url.absoluteString
        cache.loadImage(atUrl: url, fitSize: fitSize) { [weak self] (urlStr, image) in
            if self?.swiftUrlKey == urlStr {
                self?.image = image
                completion?(image)
            }
        }
    }
    
    fileprivate func value<T>(_ key:UnsafeMutableRawPointer?, _ defaultValue:T) -> T {
        return (objc_getAssociatedObject(self, key) as? T) ?? defaultValue
    }
    
    private var swiftUrlKey: String {
        get {
            return value(_swiftUrlKey, "")
        }
        set {
            objc_setAssociatedObject(self, _swiftUrlKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        }
    }
}
