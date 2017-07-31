//
//  Function.swift
//  SwiftyImageCache
//
//  Created by luan on 7/31/17.
//
//

import Foundation

func cacheFileUrl(_ fileName: String) -> URL {
    let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    return cacheURL.appendingPathComponent(fileName)
}
