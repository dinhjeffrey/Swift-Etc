//
//  ArticleController.swift
//  Delicious
//
//  Created by Sean Choo on 4/27/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import UIKit

class ArticleController: UITableViewController {
    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    
    
    // The currentArticle variable is used to hold the article being displayed. The initializeArticle() method helps setup the article details, and it initializes a sample article after the view has finished loading.
    var currentArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // First, we declare two constants for holding the screen width and height of the device. And we make use of the self sizing cell feature by setting the row height to UITableViewAutomaticDimension and giving the table view an estimated row height.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500.0
        
        initializeArticle()
        addFooterView()
    }
    
    func initializeArticle() {
        let mainContent = "Start your day with this amazing breakfast, and you will be happy throughout the day"
        let article = Article(title: "Lovely Breakfast", mainContent: mainContent, coverPhoto: "Toast", coverPhotoWidth: 1080, coverPhotoHeight: 810, mealType: "Breakfast", mealPrice: 34)
        article.restaurantName = "Toast Box"
        article.restaurantAddress = "G/F, JD Mall, 233-239 Nathan Rd, Jordan"
        article.restaurantLatitude = 22.304864882982680
        article.restaurantLongitude = 114.171386361122100
        article.authorDisplayName = "The Dreamer"
        article.authorUsername = "dreamer"
        
        let subContentOne = SubContent(photo: "Egg", photoWidth: 1080, photoHeight: 810, text: "Half-boiled eggs is a must")
        let subContentTwo = SubContent(photo: "Tea", photoWidth: 1080, photoHeight: 810, text: "Singapore/Malaysia-styled milk tea. Milder than Hong Kong style but still great")
        
        article.subContents = [subContentOne, subContentTwo]
        currentArticle = article
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
         Each article contains the following sections:
         
         The first section is for the cover photo.
         The second section is for the article title, plus the main content.
         The rest of the section is for the subcontents.
         Therefore, the total number of rows is 2 + article.subContents.count.
        */
        if let article = currentArticle {
            return 2 + article.subContents.count
        } else {
            return 0
        }
    }
    // For the cover photo row, we have to calculate the row height. For example, if a cover photo is 4w : 3h in ratio, height ratio will be 3 / 4 = 0.75 and row height would be screen width (e.g. 375 for iPhone 6S) * 0.75 = 281.25. For the rest of the rows, it is good enough to use automatic row height.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if let width = currentArticle?.coverPhotoWidth, height = currentArticle?.coverPhotoHeight {
                let heightRatio = height / width
                return screenWidth * heightRatio
            }
        }
        return UITableViewAutomaticDimension
    }
    // First, instead of using a normal string for text in the article, we use NSMutableAttributedString, that the article will be more pleasant to read. The attributedContentFromText() method is a helper method for converting a string to a NSMutableAttributedString. The rest of the code is pretty straightforward. We simply configure the cells for cover photo row, title/main content row, and the sub content rows.
    func attributedContentFromText(text: String) -> NSMutableAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 7
        let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(15),
                            NSParagraphStyleAttributeName: paraStyle]
        let attrContent = NSMutableAttributedString(string: text, attributes: attrs)
        return attrContent
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellForRow: UITableViewCell!
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CoverPhotoCell", forIndexPath: indexPath) as! CoverPhotoTableViewCell
            
            if let imageName = currentArticle?.coverPhoto {
                cell.coverImageView.image = UIImage(named: imageName)
            }
            cellForRow = cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("MainContentCell", forIndexPath: indexPath) as! MainContentTableViewCell
            cell.titleLabel.text = currentArticle?.title
            
            cell.contentLabel.textAlignment = .Left
            if let text = currentArticle?.mainContent {
                cell.contentLabel.attributedText = attributedContentFromText(text)
            }
            cellForRow = cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SubContentCell", forIndexPath: indexPath) as! SubContentTableViewCell
            
            if let article = currentArticle {
                let subContent = article.subContents[indexPath.row - 2]
                
                if let width = subContent.photoWidth, height = subContent.photoHeight {
                    let heightRatio = height / width
                    cell.subImageViewHeight.constant = screenWidth * heightRatio
                }
                
                if let imageName = subContent.photo {
                    cell.subImageView.image = UIImage(named: imageName)
                }
                
                cell.subContentLabel.textAlignment = .Left
                if let text = subContent.text {
                    cell.subContentLabel.attributedText = attributedContentFromText(text)
                }
            }
            cellForRow = cell
        }
        return cellForRow
    }
    
    
    func addFooterView() {
        let  footerView = NSBundle.mainBundle().loadNibNamed("ArticleFooterView", owner: self, options: nil)[0] as! ArticleFooterView
        footerView.frame = CGRectMake(0, 0, screenWidth, 486)
        
        footerView.separatorHeight.constant = 0.6
        
        if let type = currentArticle?.mealType, price = currentArticle?.mealPrice {
            footerView.mealTypeLabel.text = type
            footerView.mealPriceLabel.text = "HK$ \(price)"
        }
        
        if let name = currentArticle?.restaurantName, address = currentArticle?.restaurantAddress {
            footerView.restaurantNameLabel.text = name
            footerView.restaurantAddressLabel.text = address
        }
        
        if let name = currentArticle?.authorDisplayName, username = currentArticle?.authorUsername {
            footerView.displayNameLabel.text = name
            footerView.usernameLabel.text = "@\(username)"
        }
        tableView.tableFooterView = footerView
    }
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
