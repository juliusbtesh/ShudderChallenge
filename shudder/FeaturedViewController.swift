//
//  FeaturedViewController.swift
//  shudder
//
//  Created by Julius Btesh on 9/25/18.
//  Copyright © 2018 Julius Btesh. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
    var categoriesPhotos = [Int: [FlickrPhoto]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for num in 0...categories.count-1 {
            loadCategories(index: num)
        }
    }
    
    func loadCategories(index: Int) {
        var count: Int = 15
        if index == 0 {
            count = 6
        }
        var page = ((index-1)*count)
        if index == 0 {
            page = 0
        }
        FlickrAPI.fetchPhotosForSearchText(searchText: "thriller", count: count, page: page) { (error, photos) in
            if let photos = photos {
                self.categoriesPhotos[index] = photos
                DispatchQueue.main.sync {
//                                    self.tableView.reloadData()
                    self.tableView.reloadSections(IndexSet(integer: index), with: .automatic)
                }
            }
        }
    }
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
            return 5
        } else {
            return 28
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: self.tableView(tableView, heightForHeaderInSection: section)))
        
        headerView.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel()
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.textColor = UIColor(hex: "717E86")
        headerLabel.font = UIFont.init(name: "Helvetica", size: 14)
        
        let headerLabelHeight: CGFloat = headerView.frame.size.height*0.7
        headerLabel.frame = CGRect(x: 10, y: headerLabelHeight/2-5, width: headerView.frame.size.width-20, height: headerLabelHeight)
                
        headerView.addSubview(headerLabel)
        
        return headerView
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
        var cell: CategoryCell
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "heroCell") as! HeroCell
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
        }
        
        if let photos = categoriesPhotos[indexPath.section] {
            cell.giveCategories(filmsArray: photos)
        }
        cell.tag = indexPath.section
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
