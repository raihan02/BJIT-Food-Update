//
//  AdminViewController.swift
//  Hungry
//
//  Created by uxd on 28/10/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import UIKit
import RealmSwift
class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuListTableView: UITableView!
    @IBOutlet weak var takeDate: UILabel!
    @IBOutlet weak var itemText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    
    var setDate = Set<String>()
    
    var getDateString = ""
    let realm = try! Realm()
    var itemList : Results <menuItem>?
    
    
    var dateFormate : Results<dateClass>?
    let aDate = dateClass()
   // var flag : Bool
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        let today = Date()
        let month = Calendar.current.component(.month, from: today)
        menuListTableView.delegate = self
        menuListTableView.dataSource = self
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
        //removeData()
        
    }
    @IBAction func logOutButton(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let info = story.instantiateViewController(withIdentifier: "mainPage")
        show(info, sender: self)
    }
    
    @IBAction func addItemButton(_ sender: UIButton) {
        let anItem = menuItem()
        let Price = priceText.text!
        let Item = itemText.text!
        for item in itemList!{
            if item.itemName == Item{
            let nameAlert = UIAlertController(title: "Item name already exist",message: "", preferredStyle: .alert)
                nameAlert.addAction(UIAlertAction(title: "Error", style: .cancel, handler: nil))
                   self.present(nameAlert, animated: true, completion: nil)
                
                return
                
            }
            
        }
        anItem.itemName = Item
        anItem.itemPrice = Price
        
        do {
            try realm.write{
                realm.add(anItem)
            }
        }
        catch{
            print(error)
        }
        menuListTableView.reloadData()
    }
    
    @IBAction func deleteItamButton(_ sender: UIButton) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuListTableView.dequeueReusableCell(withIdentifier: "cellAdmin", for: indexPath)
       
        cell.textLabel?.text =  itemList?[indexPath.row].itemName ?? "No name included"
        cell.detailTextLabel?.text = "Price: " + (itemList?[indexPath.row].itemPrice)!
        return cell
    
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIteamName = itemList?[indexPath.row].itemName
        let selectedIteamPrice = itemList?[indexPath.row].itemPrice
         
        let anObject = menuItem()
        
        anObject.itemName = selectedIteamName ?? ""
        anObject.itemPrice = selectedIteamPrice ?? ""
        anObject.status = ""
        realm.delete(anObject)

    }
 */
    
    @IBAction func deleteButton(_ sender: UIButton) {
       
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            if let item = itemList?[indexPath.row] {
                try! realm.write {
                    realm.delete(item)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
    
    
    
    
    func dataView()
    {
         menuListTableView.reloadData()
        itemList = realm.objects(menuItem.self)
        dateFormate = realm.objects(dateClass.self)
       
         
        for item in dateFormate!{
            setDate.insert(item.getDate)
        }
        
        print("Count: ", setDate.count)
        if setDate.count > 1{
            removeData()
           setDate = Set<String>()
        }
        
        
        
        
     }
    func removeData()
    {
        do{
        try realm.write {
            let allNotifications = realm.objects(dateClass.self)
            let menu = realm.objects(menuItem.self)
            let orderList = realm.objects(staffItem.self)
           //let amount = realm.objects(amountInfo.self)
            realm.delete(menu)
            realm.delete(allNotifications)
            realm.delete(orderList)
            //realm.delete(amount)
         }
        }
        catch{
            print(error)
        }
    }

}
