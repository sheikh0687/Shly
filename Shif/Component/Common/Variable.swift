//
//  Variable.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import Foundation
import UIKit

var globalUserName          =       k.userDefault.value(forKey: "user_name")
var globalUserImage         =       k.userDefault.value(forKey: "user_image")

var isLogout:Bool = false

var localTimeZoneIdentifier: String { return
    TimeZone.current.identifier }

struct dataModel {
    var selectedName : String
    var selectedPrice : String
}

enum emLang: String {
    case english
    case french
}
var cLang: emLang = .english

enum Status: String {
    case open = "OPEN"
    case close = "CLOSE"
}

struct TimeSlot {
    var open_day: String?
    var open_time: String?
    var close_time: String?
    var status: Status
}
