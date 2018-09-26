//
//  CategoryCell.swift
//  shudder
//
//  Created by Julius Btesh on 9/25/18.
//  Copyright © 2018 Julius Btesh. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!

    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    var films: [FlickrPhoto] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func giveCategories(filmsArray: [FlickrPhoto]) {
        activityView.stopAnimating()
        films = filmsArray
        collectionView.reloadData()
    }
    
    func cellWidth() -> CGFloat {
        let itemsPerRow:CGFloat = 4.0
        
        var itemWidth = (collectionView.bounds.width / itemsPerRow) - PADDING
        itemWidth *= 1.15
        
        return itemWidth
    }
    
    func identifier() -> String {
        return "filmCell"
    }
    
    func itemToShow(indexPath: IndexPath) -> FlickrPhoto? {
        return films[indexPath.row]
    }
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier(), for: indexPath) as! FilmCell
        if let photo = itemToShow(indexPath: indexPath) {
            cell.configureCell(photo: photo)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
}

extension CategoryCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemHeight = collectionView.bounds.height - (2 * PADDING)
        
        return CGSize(width: cellWidth(), height: itemHeight)
    }
}
