//
//  DetailViewController.swift
//  SwiftyImageCache
//
//  Created by Minh Luan Tran on 8/4/17.
//
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.setUrl(url, qualityFactor: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
