//
//  Category.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 20/10/23.
//

import Foundation

struct Api_Category : Codable {
    
    let result : [Res_Category]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_Category].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_Category : Codable {
    let id : String?
    let name : String?
    let color_code : String?
    let name_fr : String?
    let price : String?
    let image : String?
    let status : String?
    let remove_status : String?
    let date_time : String?
    let display_order : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case color_code = "color_code"
        case name_fr = "name_fr"
        case price = "price"
        case image = "image"
        case status = "status"
        case remove_status = "remove_status"
        case date_time = "date_time"
        case display_order = "display_order"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        color_code = try values.decodeIfPresent(String.self, forKey: .color_code)
        name_fr = try values.decodeIfPresent(String.self, forKey: .name_fr)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        display_order = try values.decodeIfPresent(String.self, forKey: .display_order)
    }
}
