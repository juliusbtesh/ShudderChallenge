//
//  FilmCell.swift
//  shudder
//
//  Created by Julius Btesh on 9/25/18.
//  Copyright © 2018 Julius Btesh. All rights reserved.
//

import UIKit
import SDWebImage

class FilmCell: UICollectionViewCell {
    
    //@IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imageView: UIImageView?
    
    var photo: FlickrPhoto?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        layer.cornerRadius = 5
    }
    
    func configureCell(photo: FlickrPhoto?) {
        guard photo != nil else {
            print("No photo")
            return
        }
        sd_addActivityIndicator()
        imageView?.sd_setImage(with: photo?.photoUrl) { (image, error, type, url) in
            self.sd_removeActivityIndicator()
        }
    }
}
