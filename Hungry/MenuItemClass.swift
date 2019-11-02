//
//  MenuItemClass.swift
//  Hungry
//
//  Created by uxd on 28/10/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import Foundation
import RealmSwift
class  menuItem : Object{
    @objc dynamic var itemName = ""
    @objc dynamic var itemPrice = ""
    @objc dynamic var status = ""
}
