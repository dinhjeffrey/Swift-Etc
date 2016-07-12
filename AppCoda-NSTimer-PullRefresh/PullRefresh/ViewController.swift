//
//  ViewController.swift
//  PullRefresh
//
//  Created by Gabriel Theodoropoulos on 6/6/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblDemo: UITableView!
    
    var dataArray: Array<String> = ["One", "Two", "Three", "Four", "Five"]
    var refreshControl: UIRefreshControl!
    var customView: UIView!
    var labelsArray: Array<UILabel> = []
    var timer: NSTimer!
    /*
     The isAnimating flag (obviously) indicates whether the custom animation is taking place or not. We’ll use it so we know if we can start a new animation or not (apparently, we don’t want a second animation process to begin while another one has already started).
     The currentColorIndex will be used to another custom function we’ll implement. In this function, we’ll have an array of colors (the text colors actually), and this property will indicate the next color that should be applied to the appropriate label.
     The currentLabelIndex property is indicating the index of the label that the first animation part is being applied to. With it not only we’ll be able to know what’s the next label that should be rotated and re-colored, but also to tell for sure when the second part of the animation (scale up) should begin.
    */
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblDemo.delegate = self
        tblDemo.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clearColor()
        refreshControl.tintColor = UIColor.clearColor()
        tblDemo.addSubview(refreshControl)
        loadCustomRefreshContents()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = dataArray[indexPath.row]
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func loadCustomRefreshContents() {
        let refreshContents = NSBundle.mainBundle().loadNibNamed("RefreshContents", owner: self, options: nil)
        
        customView = refreshContents[0] as! UIView
        customView.frame = refreshControl.bounds
        
        for i in 0 ..< customView.subviews.count {
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
        }
        
        refreshControl.addSubview(customView)
    }
    // In the first animation block we perform the rotation and text color changing for the current label (see the currentLabelIndex property).
    //When that sub-animation is over, we want to revert the label to its initial state and this must happen gracefully, not instantly. Obviously, that’s why we need the second animation block.
    func animateRefreshStep1() {
        isAnimating = true
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { 
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
            }) { (finished) in
                UIView.animateWithDuration(0.05, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { 
                    self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformIdentity
                    self.labelsArray[self.currentLabelIndex].textColor = UIColor.blackColor()
                    }, completion: { (finished) in
                        self.currentLabelIndex += 1
                        
                        if self.currentLabelIndex < self.labelsArray.count {
                            self.animateRefreshStep1()
                        } else {
                            self.animateRefreshStep2()
                        }
                })
        }
    }
    /*
     Once again, we use two animation blocks. In the first one, we scale up all labels. Note that we can’t use a loop to do that (for example a for statement). The loop would be executed regardless of the animation duration, and it would have finished a lot before all labels to have been scaled up.
     
     Upon completion, we set the initial transformation to all labels, so they get their initial state once again. On the completion handler of the inner animation block, there’s an if statement. There, if the refresh is still in progress we get prepared to re-run the whole animation. This is done simply by setting the initial value (0) to the currentLabelIndex property, and by calling the first custom function to perform the animation. We will deal with the end of the refreshing in the next part. However, if the refresh process has already ended, then we indicate that we are not animating any more by changing the isAnimating flag value, and of course, we set the initial values to all properties (and views) that take part in the animation process. This is necessary, so the animation to properly start over in the next pull of the tableview.
     */
    func animateRefreshStep2() {
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { 
            self.labelsArray[0].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[1].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[2].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[3].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[4].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[5].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[6].transform = CGAffineTransformMakeScale(1.5, 1.5)
            }) { (finished) in
                UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { 
                    self.labelsArray[0].transform = CGAffineTransformIdentity
                    self.labelsArray[1].transform = CGAffineTransformIdentity
                    self.labelsArray[2].transform = CGAffineTransformIdentity
                    self.labelsArray[3].transform = CGAffineTransformIdentity
                    self.labelsArray[4].transform = CGAffineTransformIdentity
                    self.labelsArray[5].transform = CGAffineTransformIdentity
                    self.labelsArray[6].transform = CGAffineTransformIdentity
                    }, completion: { (finished) in
                        if self.refreshControl.refreshing {
                            self.currentLabelIndex = 0
                            self.animateRefreshStep1()
                        } else {
                            self.isAnimating = false
                            self.currentLabelIndex = 0
                            for i in 0 ..< self.labelsArray.count {
                                self.labelsArray[i].textColor = UIColor.blackColor()
                                self.labelsArray[i].transform = CGAffineTransformIdentity
                            }
                        }
                })
        }
    }
    
    // The question that now arises is where exactly the custom animation should begin. If you look closely to the animated graphic in the beginning of this part, you’ll find out that it starts once the tableview dragging is over. Programmatically speaking, and considering that the tableview is a subclass of the scroll view, the delegate method we are interested in is the scrollViewDidEndDecelerating(_:). This one is called every time the tableview scrolling gets stopped. In this one, initially we’ll check if a refresh is in progress or not. In case it is, we’ll check the value of the isAnimating flag, and if no animation is taking place, we’ll initiate it by calling the first function we implemented before. Here’s what I just said converted in code:
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl.refreshing {
            if !isAnimating {
                doSomething()
                animateRefreshStep1()
            }
        }
    }
    // It’s quite simple what we do here. At first, we prepare an array with some predefined colors (the order is totally random). Then, we make sure that the currentColorIndex property has a valid value, and if not, we set its initial value (0). We keep the color that is indicated by that property, and we increase its value, so the next time that this function will be called we won’t get the same color. At the end, the selected color is returned.
    func getNextColor() -> UIColor {
        var colorsArray: [UIColor] = [UIColor.magentaColor(), UIColor.brownColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.orangeColor()]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        print(currentColorIndex)
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex += 1
        
        return returnColor
    }
    
    func doSomething() {
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "endOfWork", userInfo: nil, repeats: true)
    }
    
    func endOfWork() {
        refreshControl.endRefreshing()
        
        timer.invalidate()
        timer = nil
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

