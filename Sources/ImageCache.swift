import UIKit

open class ImageCache {
    
    public static let `default` = ImageCache()
    
    private let autoCleanupDays = 30
    private var lastCleanup = UserDefaults.standard.object(forKey: "lastCleanup") as? Date ?? Date() {
        didSet {
            UserDefaults.standard.set(lastCleanup, forKey: "lastCleanup")
        }
    }
    
    let queue = DispatchQueue(label: "ImageCache")
    var workItems = NSCache<NSString, DispatchWorkItem>()
    var images = NSCache<NSString, UIImage>()
    
    open var cacheType = CacheType.disk
    
    public init() {
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification,
                                               object: self, queue: nil) {
            notification in
        }
    }
    
    open func set(image: UIImage, key: String) {
        guard let data = image.jpegData(compressionQuality: 1) else {
            return
        }
        cacheImage(data: data, key: key)
    }
    
    open func loadImage(atUrl url: URL, fitSize size: CGSize? = nil, completion: ((String, UIImage?) -> Void)? = nil) {
        let urlString = url.absoluteString
        let key = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? urlString
        DispatchQueue(label: "LoadImageQueue").async { [weak self] in
            guard self != nil else {
                return
            }
            if let image = self!.image(of: key, fitSize: size) {
                DispatchQueue.main.async {
                    completion?(urlString, image)
                }
                return
            }
            
            if let workItem = self!.workItems.object(forKey: key as NSString) {
                workItem.notify(queue: DispatchQueue(label: "NotifyQueue"), execute: { [weak self] in
                    if let image = self?.image(of: key, fitSize: size) {
                        DispatchQueue.main.async {
                            completion?(urlString, image)
                        }
                    }
                })
                return
            }
            let workItem = DispatchWorkItem { [weak self] in
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            completion?(urlString, image)
                        }
                        
                        DispatchQueue.global(qos: .utility).async {
                            self?.cacheImage(data: data, key: key)
                        }
                        
                        return
                    }
                }
                .resume()
            }
            self!.workItems.setObject(workItem, forKey: key as NSString)
            self!.queue.async(execute: workItem)
        }
    }
    
    open func image(of url: URL, fileSize size: CGSize? = nil) -> UIImage? {
        let urlString = url.absoluteString
        let key = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? urlString
        
        return image(of: key, fitSize: size)
    }
    
    open func image(of key: String, fitSize size: CGSize? = nil) -> UIImage? {
        if let image = images.object(forKey: key as NSString) {
            return image
        }
        let fileURL = cacheFileUrl(key)
        do {
            let data = try Data(contentsOf: fileURL)
            let image = UIImage(data: data)
            return size != nil ? image?.scaleToFit(in: size!) : image
        } catch {
        }
        return nil
    }
    
    open func cacheImage(_ image: UIImage, key: String) {
        switch cacheType {
        case .ram:
            images.setObject(image, forKey: key as NSString)
        case .disk:
            if let data = image.pngData() {
                let fileURL = cacheFileUrl(key)
                do {
                    try data.write(to: fileURL, options: Data.WritingOptions.atomic)
                } catch let error {
                    print("Error write file \(error.localizedDescription)")
                }
            }
        }
    }
    
    func cacheImage(data: Data, key: String) {
        switch cacheType {
        case .ram:
            if let image = UIImage(data: data) {
                images.setObject(image, forKey: key as NSString)
            }
        case .disk:
            let fileURL = cacheFileUrl(key)
            do {
                try data.write(to: fileURL, options: Data.WritingOptions.atomic)
            } catch let error {
                print("Error write file \(error.localizedDescription)")
            }
        }
    }
    
    open func clearLocalCache() {
        let fileManager = FileManager.default
        let imageDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        if Date().timeIntervalSince(lastCleanup) > TimeInterval(autoCleanupDays * 24 * 3600) {
            if fileManager.isDeletableFile(atPath: imageDirectory.path) {
                do {
                    try fileManager.removeItem(atPath: imageDirectory.path)
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
            
            lastCleanup = Date()
        }
        
        workItems.removeAllObjects()
        images.removeAllObjects()
    }
}
