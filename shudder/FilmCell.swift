//
//  FilmCell.swift
//  shudder
//
//  Created by Julius Btesh on 9/25/18.
//  Copyright © 2018 Julius Btesh. All rights reserved.
//

import UIKit

class FilmCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 10
    }
    
    func configureCell(name: String) {
        nameLabel.text = name
    }
}
