//
//  ViewController.swift
//  SwiftyImageCacheDemo
//
//  Created by Minh Luan Tran on 7/25/17.
//
//

import UIKit
import SwiftyImageCache

class ViewController: UIViewController {
    
    var urlStrings: [String] = [
        "http://breedinfo.ru/uploads/posts/2015-12/14_american_eskimo_dog.jpg",
        "http://www.hdwallpapersfreedownload.com/uploads/large/animals/dog-high-quality-wallpapers.jpg",
        "http://www.dailypicsupdate.com/wp-content/uploads/2012/12/Dog-1920X1200-wide-high-quality.jpg",
        "http://desinewszone.com/wp-content/uploads/2016/08/img8.jpg",
        "http://thiswallpaper.com/cdn/hdwallpapers/887/pitbull%20animal%20dog%20high%20quality%20wallpaper.jpg",
        "https://userscontent2.emaze.com/images/cf4fda28-05de-46ce-93d0-0da4463f5e8e/eb7554ae8c79c3f9b131236d36a7af5b.jpg",
        "http://www.hdwallpapersfreedownload.com/uploads/large/animals/dog-photo.jpg",
        "http://www.piccolaspressies.co.uk/resources/4.jpg",
        "http://www.adogsjoy.com/img/slide-1.jpg",
    ]
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController,
            let urlString = sender as? String,
            let url = URL(string: urlString) {
            detailVC.url = url
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "showDetailSegue", sender: urlStrings[indexPath.row])
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.url = URL(string: urlStrings[indexPath.row])
        return cell
    }
    
}

class Cell: UITableViewCell {
    @IBOutlet weak var contentImageView: UIImageView!
    var url: URL? {
        didSet {
            if let url = url {
                contentImageView.image = nil
                contentImageView.setUrl(url, qualityFactor: 2.0)
            }
        }
    }
}

