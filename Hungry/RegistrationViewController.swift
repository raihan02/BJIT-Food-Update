//
//  RegistrationViewController.swift
//  Hungry
//
//  Created by uxd on 24/10/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import UIKit
import RealmSwift
class RegistrationViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let realm = try! Realm()
    var anArray : Results<RegistrationInfo>?
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    private let list = ["Staff","Admin"]
    var aUser = RegistrationInfo()
    var selectedRole = ""
    var checkPassword = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        passwordText.isSecureTextEntry = true
        confirmPasswordText.isSecureTextEntry = true
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        selectedRole = self.list[row]
        self.dropDown.isHidden = false
    }
    
    func checkIssues( issueId: Int)
    {
        
        //print("Issue: ", issueId)
        var issueString : String = ""
        var issueTitle : String = ""
        var issueMassege : String = ""
        if issueId == 0
        {
            issueString = "Name is Empty"
            issueTitle = "Error"
            issueMassege = "Enter a valid name"
        }
        
        if issueId == 1{
            issueString = "ID is Empty"
            issueTitle = "Error"
            issueMassege = "Enter a valid id"
        }
        else if issueId == 2{
            issueString = "Password is Empty"
            issueTitle = "Error"
            issueMassege = "Enter a valid password"
        }
        else if issueId == 3{
            issueString = "Role is empty"
            issueTitle = "Error"
            issueMassege = "Select a role"
        }
        else if issueId == 4{
            issueString = "Password is not match"
            issueTitle = "Error"
            issueMassege = "Please enter the correct password"
        }
        else if issueId == 5{
            issueString = "User is already exist"
            issueMassege = "Please enter another user Id"
            issueTitle = "Error"
        }
        else if issueId == 6{
            issueString = "Successfully Registered"
            issueMassege = ""
            issueTitle = "Done"
        }
        
    
        let nameAlert = UIAlertController(title: issueString, message: issueMassege, preferredStyle: .alert)
        nameAlert.addAction(UIAlertAction(title: issueTitle, style: .cancel, handler: nil))
        self.present(nameAlert, animated: true, completion: nil)
    
    }
    @IBAction func registrationSubmitButton(_ sender: UIButton) {
        
        
        aUser.userName = nameText.text!
        aUser.userID = idText.text!
        aUser.userPassword = passwordText.text!
        aUser.userRole = selectedRole
        checkPassword =  confirmPasswordText.text!
        var issueCheck : Bool = false
        if aUser.userName.isEmpty && issueCheck == false{
              issueCheck = true
            checkIssues(issueId: 0)
        }
        if aUser.userID.isEmpty && issueCheck == false{
            issueCheck = true
            checkIssues(issueId: 1)
        }
        if aUser.userPassword.isEmpty && issueCheck == false{
            issueCheck = true
            checkIssues(issueId: 2)
        }
        if aUser.userRole.isEmpty && issueCheck == false{
            issueCheck = true
            checkIssues(issueId: 3)
        }
        if aUser.userPassword != checkPassword && issueCheck == false{
            issueCheck = true
            checkIssues(issueId: 4)
        }
    
        do {
            try realm.write{
                anArray = realm.objects(RegistrationInfo.self)
                for item in anArray!{
                    if aUser.userID == item.userID && issueCheck == false{
                        issueCheck = true
                        checkIssues(issueId: 5)
                        break
                    }
                }
                if(issueCheck == false){
                    checkIssues(issueId: 6)
                    realm.add(aUser)
                }
            }
        }
        catch{
            print(error)
        }
        
      
        
    }
}
