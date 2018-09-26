//
//  FeaturedViewController.swift
//  shudder
//
//  Created by Julius Btesh on 9/25/18.
//  Copyright © 2018 Julius Btesh. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    // List of Categories in the featured section
    let categories = ["Hero",
                      "Newly Added",
                      "Curator's Choice",
                      "Back to School",
                      "Get Rad",
                      "Vengeance is Hers",
                      "Monster Mash",
                      "Haunts",
                      "Binge This"]
    
    var storedOffsets = [Int: CGFloat]() // Keep track of each tableView's offset to place back when cell reloads

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GetFlickrData()
    }
    
    func GetFlickrData() {
        FlickrProvider.fetchPhotosForSearchText(searchText: "new", count: 5) { (error, photos) in
            if let photos = photos {
                for photo in photos {
                    print(photo.server)
                    print(photo.photoUrl)
                }
            }
        }
        
    }
    
//    func addNewItem(title: String, data: NSData?){
//        guard data != nil else{
//            print ("Error")
//            return
//        }
//        let image = UIImage(data: data!)
//        let item = Item(title: title, image: image)
//        itemList.append(item)
//        print (item.title)
//        
//    }
}

extension FeaturedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        return 150
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CategoryCell else { return }
        
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.section] ?? 0
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CategoryCell else { return }
        
        storedOffsets[indexPath.section] = tableViewCell.collectionViewOffset
    }
}

extension FeaturedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = "categoryCell"
        if indexPath.section == 0 {
            identifier = "heroCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CategoryCell
        cell.tag = indexPath.section
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
}
