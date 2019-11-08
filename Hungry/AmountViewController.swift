//
//  AmountViewController.swift
//  Hungry
//
//  Created by uxd on 4/11/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import UIKit
import RealmSwift
class AmountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    let realm = try! Realm()
    var itemList : Results <amountInfo>?
    @IBOutlet weak var amountTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTableView.delegate = self
        amountTableView.dataSource = self
        dataLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = amountTableView.dequeueReusableCell(withIdentifier: "amountCell", for: indexPath) as! AmountTableViewCell
        cell.name.text = itemList?[indexPath.row].staffName
        cell.id.text = itemList?[indexPath.row].staffId
        cell.price.text = itemList?[indexPath.row].itemPrice
        cell.backgroundColor = UIColor.yellow
        return cell
        
    }
    
    func dataLoad()
    {
        itemList = realm.objects(amountInfo.self)
        amountTableView.reloadData()
    }
    
}
