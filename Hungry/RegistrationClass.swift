//
//  RegistrationClass.swift
//  Hungry
//
//  Created by uxd on 24/10/19.
//  Copyright © 2019 uxd. All rights reserved.
//

import Foundation
import RealmSwift
class  RegistrationInfo : Object{
    @objc dynamic var userName = ""
    @objc dynamic var userID = ""
    @objc dynamic var userPassword = ""
    @objc dynamic var userRole = ""
}

