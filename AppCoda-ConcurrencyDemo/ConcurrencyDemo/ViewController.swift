//
//  ViewController.swift
//  ConcurrencyDemo
//
//  Created by Hossam Ghareeb on 11/15/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

import UIKit

let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg", "http://algoos.com/wp-content/uploads/2015/08/ireland-02.jpg", "http://bdo.se/wp-content/uploads/2014/01/Stockholm1.jpg"]

class Downloader {
    
    class func downloadImageWithURL(url:String) -> UIImage! {
        
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        return UIImage(data: data!)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didClickOnStart(sender: AnyObject) {
        // We first get a reference to the default concurrent queue using dispatch_get_global_queue, then inside the block we submit a task which is to download the first image. Once the image download completes, we submit another task to the main queue to update the image view with the downloaded image. In other words, we put the image download task in a background thread, but execute the UI related tasks in the main queue.
        let _ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let serialQueue = dispatch_queue_create("com.appcoda.imagesQueue", DISPATCH_QUEUE_SERIAL)
        dispatch_async(serialQueue) {
            let img1 = Downloader.downloadImageWithURL(imageURLs[0])
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView1.image = img1
            }
        }
        dispatch_async(serialQueue) {
            let img2 = Downloader.downloadImageWithURL(imageURLs[1])
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView2.image = img2
            }
        }
        dispatch_async(serialQueue) {
            let img3 = Downloader.downloadImageWithURL(imageURLs[2])
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView3.image = img3
            }
        }
        dispatch_async(serialQueue) {
            let img4 = Downloader.downloadImageWithURL(imageURLs[3])
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView4.image = img4
            }
        }
    }
    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        self.sliderValueLabel.text = "\(sender.value * 100.0)"
    }
    
}

