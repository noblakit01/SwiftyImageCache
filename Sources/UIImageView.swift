//
//  UIImageView.swift
//  SwiftyImageCache
//
//  Created by Minh Luan Tran on 8/4/17.
//
//

import UIKit

extension UIImageView {
    public func setUrl(_ url: URL, qualityFactor: CGFloat? = nil) {
        let fitSize = qualityFactor != nil ? bounds.size * qualityFactor! : nil
        ImageCache.default.loadImage(atUrl: url, fitSize: fitSize) { [weak self] (url, image) in
            self?.image = image
        }
    }
}
