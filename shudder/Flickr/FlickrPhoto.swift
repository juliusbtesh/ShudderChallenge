//
//  FlickrPhoto.swift
//  shudder
//
//  Created by Julius Btesh on 9/26/18.
//  Copyright © 2018 Julius Btesh. All rights reserved.
//

import UIKit

struct FlickrPhoto {
    
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_m.jpg")!
    }
    
}
