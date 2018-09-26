//
//  HeroCell.swift
//  shudder
//
//  Created by Julius Btesh on 9/26/18.
//  Copyright © 2018 Julius Btesh. All rights reserved.
//

import UIKit

class HeroCell: CategoryCell {
        
    private var indexOfCellBeforeDragging = 0
    
    private var alreadyInitialized: Bool = false
    
    func setupDataForCarousel() {
        // Grab references to the first and last items
        // They're typed as id so you don't need to worry about what kind
        // of objects the originalArray is holding
        let firstItem = films.first
        let lastItem = films.last
        
        var newArray = films
        // Add the copy of the last item to the beginning
        newArray.insert(lastItem!, at: 0)
        
        // Add the copy of the first item to the end
        newArray.append(firstItem!)
        
        // Update the collection view's data source property
        films = newArray
    }
    
    override func giveCategories(filmsArray: [FlickrPhoto]) {
        super.giveCategories(filmsArray: filmsArray)
        setupDataForCarousel()
        
        if alreadyInitialized {
            return
        }
        alreadyInitialized = true
        // Setup Hero to start at "Real" first index
        perform(#selector(HeroCell.startScroll), with: nil, afterDelay: 0.25)
    }
    
    @objc func startScroll() {
        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override func cellWidth() -> CGFloat {
        let padding:CGFloat = 5.0
        
        let itemWidth = collectionView.bounds.width - (8*padding)
        
        return itemWidth
    }
    
    override func identifier() -> String {
        return "heroFilmCell"
    }
    
    private func itemWidth() -> CGFloat {
        return collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(row: indexOfCellBeforeDragging, section: 0 )).width
    }
    
    private func indexOfMajorCell() -> Int {
        let proportionalOffset = collectionView.contentOffset.x / itemWidth()
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(films.count - 1, index))
        return safeIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let contentOffsetWhenFullyScrolledRight: CGFloat = collectionView.frame.size.width * CGFloat((films.count-2));
        if scrollView.contentOffset.x >= contentOffsetWhenFullyScrolledRight {
            
            // user is scrolling to the right from the last item to the 'fake' item 1.
            // reposition offset to show the 'real' item 1 at the left-hand end of the collection view
            
            let newIndexPath = IndexPath(item: 1, section: 0)
            
            collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: false)
            
        } else if scrollView.contentOffset.x <= 0 {//itemWidth()+5)  {
            
            // user is scrolling to the left from the first item to the fake 'item N'.
            // reposition offset to show the 'real' item N at the right end end of the collection view
            
            let newIndexPath = IndexPath(item: films.count-2, section: 0)
            collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: false)
        }
        
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()
        
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
