import UIKit

open class ImageCache {
    
    open static let `default` = ImageCache()
    
    var queue = DispatchQueue(label: "ImageCache")
    var workItems = NSCache<NSString, DispatchWorkItem>()
    var images = NSCache<NSString, UIImage>()
    
    public init() {
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidReceiveMemoryWarning,
                                               object: self, queue: nil) {
            notification in
        }
    }
    
    open func loadImage(atUrl url: URL, completion: @escaping (String, UIImage?) -> Void) {
        let urlString = url.absoluteString
        if let image = images.object(forKey: urlString as NSString) {
            completion(urlString, image)
            return
        }
        if let workItem = workItems.object(forKey: urlString as NSString) {
            workItem.notify(queue: queue, execute: { [weak self] in
                if let image = self?.images.object(forKey: urlString as NSString) {
                    DispatchQueue.main.async {
                        completion(urlString, image)
                    }
                }
            })
            return
        }
        let workItem = DispatchWorkItem { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    let cacheURL: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                    let fileName = "test.jpg"
                    let fileURL = cacheURL.appendingPathComponent(fileName)
                    do {
                        try data.write(to: fileURL, options: Data.WritingOptions.atomic)
                    } catch (let error) {
                        print("Error write file \(error.localizedDescription)")
                    }
                    self?.images.setObject(image, forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        completion(urlString, image)
                    }
                    return
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(urlString, nil)
            }
        }
        workItems.setObject(workItem, forKey: urlString as NSString)
        queue.async(execute: workItem)
    }
    
    open func clear() {
        workItems.removeAllObjects()
        images.removeAllObjects()
    }
    
    
}
