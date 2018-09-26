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
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    var films = Array(arrayLiteral: "Hero", "New", "Movie")
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as! FilmCell
        if tag == 0 {
            cell.configureCell(name: films[indexPath.row])
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
}

extension CategoryCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow:CGFloat = 4.0
        let padding:CGFloat = 5.0
        let itemHeight = collectionView.bounds.height - (2 * padding)
        
        var itemWidth:CGFloat = 0
        
        if tag == 0 {
            itemWidth = collectionView.bounds.width// - (2*padding)
        } else {
            itemWidth = (collectionView.bounds.width / itemsPerRow) - padding
            itemWidth *= 1.15
        }
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
