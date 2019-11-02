//
//  AddSection.swift
//  Hungry
//
//  Created by uxd on 30/10/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import Foundation
import RealmSwift

var itemList : Results <staffItem>?
struct sample{
    var userName = ""
    var userID = ""
    var userItem = ""
    

    
    static func allStaffs() -> [staffItem]{
     let realm = try! Realm()
     let itemList = realm.objects(staffItem.self)
     var allstf = [staffItem]()
    
        for item in itemList{
        let anObject = staffItem()
        anObject.staffName = item.staffName
        anObject.staffId = item.staffId
        anObject.staffItem = item.staffItem
        
        allstf.append(anObject)
    }
    return allstf
    
}
}
/*
struct  Section {
    
    var name : String
    
    var staffs : [staffItem]
    
    static func alphabaticallySectionedFriends() -> [Section] {
        let friends = allStaffs().sorted { $0.staffName < $1.staffName }
        
        let groupedFriends = Dictionary(grouping: friends) { String($0.staffName.first!).uppercased() }
        let sections = groupedFriends.map { Section(name: $0.key, staffs: $0.value) }
        let sortedSections = sections.sorted { $0.name < $1.name }
        return sortedSections
    }
}*/
