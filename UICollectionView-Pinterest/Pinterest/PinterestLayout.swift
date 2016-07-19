//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by jeffrey dinh on 7/18/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

//  // For this layout, you need to dynamically calculate the position and height of every item since you don’t know what the height of the photo or the annotation will be in advance. You’ll declare a protocol that will provide this position and height info when PinterestLayout needs it.
// This code declares the PinterestLayoutDelegate protocol, which has two methods to request the height of the photo (1) as well as the annotation (2). You’ll implement this protocol in PhotoStreamViewController shortly.
protocol PinterestLayoutDelegate {
  // 1 
  func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
  // 2
  func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
  
  
  
  // 1. This keeps a reference to the delegate.
  // 2. These are two public properties for configuring the layout: the number of columns and the cell padding.
  // 3. This is an array to cache the calculated attributes. When you call prepareLayout(), you’ll calculate the attributes for all items and add them to the cache. When the collection view later requests the layout attributes, you can be efficient and query the cache instead of recalculating them every time.
  // 4. This declares two properties to store the content size. contentHeight is incremented as photos are added, and contentWidth is calculated based on the collection view width and its content inset.

  // 1 
  var delegate: PinterestLayoutDelegate!
  
  // 2
  var numberOfColumns = 2
  var cellPadding: CGFloat = 6.0
  
  // 3
  private var cache = [UICollectionViewLayoutAttributes]()
  
  // 4
  private var contentHeight: CGFloat = 0.0
  private var contentWidth: CGFloat {
    let insets = collectionView!.contentInset
    return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
  }
  
  /*
   prepareLayout(): This method is called whenever a layout operation is about to take place. It’s your opportunity to prepare and perform any calculations required to determine the collection view size and the positions of the items.
   You’ll calculate the frame of every item based on its column (tracked by xOffset) and the position of the previous item in the same column (tracked by yOffset).
   To calculate the horizontal position, you’ll use the starting X coordinate of the column the item belongs to, and then add the cell padding. The vertical position is the starting position of the prior item in that column, plus the height of that prior item. The overall item height is the sum of the image height, the annotation height and the content padding.
   You’ll do this in prepareLayout(), where your primary objective is to calculate an instance of UICollectionViewLayoutAttributes for every item in the layout.
   
   1. You only calculate the layout attributes if cache is empty.
   2. This declares and fills the xOffset array with the x-coordinate for every column based on the column widths. The yOffset array tracks the y-position for every column. You initialize each value in yOffset to 0, since this is the offset of the first item in each column.
   3. This loops through all the items in the first section, as this particular layout has only one section.
   4. This is where you perform the frame calculation. width is the previously calculated cellWidth, with the padding between cells removed. You ask the delegate for the height of the image and the annotation, and calculate the frame height based on those heights and the predefined cellPadding for the top and bottom. You then combine this with the x and y offsets of the current column to create the insetFrame used by the attribute.
   5. This creates an instance of UICollectionViewLayoutAttribute, sets its frame using insetFrame and appends the attributes to cache.
   6. This expands contentHeight to account for the frame of the newly calculated item. It then advances the yOffset for the current column based on the frame. Finally, it advances the column so that the next item will be placed in the next column.
   
   Note: As prepareLayout() is called whenever the collection view’s layout is invalidated, there are many situations in a typical implementation where you might need to recalculate attributes here. For example, the bounds of the UICollectionView might change – such as when the orientation changes – or items may be added or removed from the collection. These cases are out of scope for this tutorial, but it’s important to be aware of them in a non-trivial implementation.
 */
  override func prepareLayout() {
    // 1
    if cache.isEmpty {
      // 2
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset = [CGFloat]()
      for column in 0..<numberOfColumns {
        xOffset.append(CGFloat(column) * columnWidth)
      }
      var column = 0
      var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
      
      // 3
      for item in 0..<collectionView!.numberOfItemsInSection(0) {
        
        let indexPath = NSIndexPath(forItem: item, inSection: 0)
        
        // 4
        let width = columnWidth - cellPadding * 2
        let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
        let annotationHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
        let height = cellPadding + photoHeight + annotationHeight + cellPadding
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
        
        // 5
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
        
        // 6 
        contentHeight = max(contentHeight, CGRectGetMaxX(frame))
        yOffset[column] = yOffset[column] + height
        
        column = column >= (numberOfColumns - 1) ? 0 : ++column
      }
    }
  }
  
  // collectionViewContentSize(): In this method, you have to return the height and width of the entire collection view content — not just the visible content. The collection view uses this information internally to configure its scroll view content size.
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  // layoutAttributesForElementsInRect(_:): In this method you need to return the layout attributes for all the items inside the given rectangle. You return the attributes to the collection view as an array of UICollectionViewLayoutAttributes.
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    //Here you iterate through the attributes in cache and check if their frames intersect with rect, which is provided by the collection view. You add any attributes with frames that intersect with that rect to layoutAttributes, which is eventually returned to the collection view.
    for attributes in cache {
      if CGRectIntersectsRect(attributes.frame, rect) {
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}

