//
//  ViewController.swift
//  Hungry
//
//  Created by uxd on 24/10/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {

    @IBOutlet weak var logInIdText: UITextField!
    @IBOutlet weak var loginPasswordText: UITextField!
    var userArray : Results <RegistrationInfo>?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logInButton(_ sender: UIButton) {
        userArray = realm.objects(RegistrationInfo.self)
        var flag: Bool = false
        for item in userArray!{
            
            if item.userID == logInIdText.text && item.userPassword == loginPasswordText.text{
                print("login with \(item.userID)")
                let getRole = item.userRole
                flag = true
                if getRole == "Admin"
                {
                    let story = UIStoryboard(name: "Main", bundle: nil)
                    let info = story.instantiateViewController(withIdentifier: "admin")
                    show(info, sender: self)
                }
                else{
                    let story = UIStoryboard(name: "Main", bundle: nil)
                    let info = story.instantiateViewController(withIdentifier: "staff") as! staffViewController
                    info.holdStaffName = item.userName
                    info.holdStaffId = item.userID
                    show(info, sender: self)
                }
                break
            }

         }
        
        if flag == false{
            let nameAlert = UIAlertController(title: "In Valid User ID or Password", message: "Please enter correct id or password", preferredStyle: .alert)
            nameAlert.addAction(UIAlertAction(title: "Error", style: .cancel, handler: nil))
               self.present(nameAlert, animated: true, completion: nil)
        }
    }
    
}

