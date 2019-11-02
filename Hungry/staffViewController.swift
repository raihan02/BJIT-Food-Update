//
//  staffViewController.swift
//  Hungry
//
//  Created by uxd on 28/10/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import UIKit
import RealmSwift
class staffViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var staffName: UILabel!
    @IBOutlet weak var staffTableView: UITableView!
    var holdStaffName = ""
    var holdStaffId = ""
    let realm = try! Realm()
    var itemList : Results <menuItem>?
    var staffItemList : Results<staffItem>?
    var item = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        staffTableView.delegate = self
        staffTableView.dataSource = self
        staffName.text = "Hello Mr/Mrs: " + holdStaffName + "-San"
        print(holdStaffId)
      // allStaffs()
        //print(itemList?.count)
        dataView()
    }
    
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemList?.count ?? 1
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell = staffTableView.dequeueReusableCell(withIdentifier: "staffCell", for: indexPath)
            cell.textLabel?.text =  itemList?[indexPath.row].itemName ?? "No name included"
            cell.detailTextLabel?.text = "Price: " + (itemList?[indexPath.row].itemPrice)!
            return cell
       }
      
    func dataView()
    {
        itemList = realm.objects(menuItem.self)
        staffTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemObject = itemList?[indexPath.row]
        item = itemObject!.itemName
        //show()
    }
    
    
    @IBAction func logOutButton(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let info = story.instantiateViewController(withIdentifier: "mainPage")
        show(info, sender: self)
    }
    
    @IBAction func orderButton(_ sender: UIButton) {
        
        let anObject = staffItem()
        
        anObject.staffId = holdStaffId
        anObject.staffName = holdStaffName
        anObject.staffItem = item
        
        do {
            try realm.write {
                staffItemList = realm.objects(staffItem.self)
                var flag: Bool = false
                for item in staffItemList!{
                    if item.staffId == anObject.staffId{
                        flag = true
                       
                        let nameAlert = UIAlertController(title: "Already Ordered", message: "", preferredStyle: .alert)
                        nameAlert.addAction(UIAlertAction(title: "", style: .cancel, handler: nil))
                        self.present(nameAlert, animated: true, completion: nil)
                        break
                    }
                }
                if flag == false{
                realm.add(anObject)
                    let nameAlert = UIAlertController(title: "Successfully Ordered", message: "", preferredStyle: .alert)
                    nameAlert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                    self.present(nameAlert, animated: true, completion: nil)
                }
            }
        }
        catch{
            print(error)
        }
        var sum : Double = 0.0
        for item in itemList!{
            sum += Double(item.itemPrice) ?? 0.0
        }
        
        amountLabel.text = String(sum)

    }
    
    func removeData()
    {
        do{
        try realm.write {
            let allNotifications = realm.objects(menuItem.self)
            realm.delete(allNotifications)
        }
        }
        catch{
            print(error)
        }
    }
    
    

}
