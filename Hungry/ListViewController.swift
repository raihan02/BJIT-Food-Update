//
//  ListViewController.swift
//  Hungry
//
//  Created by uxd on 29/10/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import UIKit
import RealmSwift
class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var takeDate: UILabel!
    
    let realm = try! Realm()
    var itemList : Results <staffItem>?
    var getDateString = ""
    let aDate = dateClass()
    
    @IBOutlet weak var newTable: UITableView!
    @IBOutlet weak var checkTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newTable.dataSource = self
        newTable.delegate = self
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let today = Date()
        let month = Calendar.current.component(.month, from: today)
        let date = Calendar.current.component(.day, from: today)
        takeDate.text = "Date: " + String(date) + "/" + String(month)
        getDateString = String(date) + "/" + String(month)
        
        aDate.getDate = getDateString
         do {
                 try realm.write{
                    realm.add(aDate)
                 }
             }
             catch{
                 print(error)
             }
        dataView()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = newTable.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! CellTableViewCell
        
        cell.nameLabel.text = itemList?[indexPath.row].staffName
        cell.idLabel.text = itemList?[indexPath.row].staffId
        cell.itemLabel.text = itemList?[indexPath.row].staffItem
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    func dataView()
    {
        itemList = realm.objects(staffItem.self)
        
        newTable.reloadData()
    }
}

