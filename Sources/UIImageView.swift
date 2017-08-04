//
//  UIImageView.swift
//  SwiftyImageCache
//
//  Created by Minh Luan Tran on 8/4/17.
//
//

import UIKit

extension UIImageView {
    public func setUrl(_ url: URL, qualityFactor: CGFloat? = nil, cache: ImageCache = .default, completion: ((UIImage?) -> Void)? = nil) {
        let fitSize = qualityFactor != nil ? bounds.size * qualityFactor! : nil
        cache.loadImage(atUrl: url, fitSize: fitSize) { [weak self] (url, image) in
            self?.image = image
            completion?(image)
        }
    }
}
