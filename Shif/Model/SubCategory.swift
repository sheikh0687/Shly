//
//  SubCategory.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 28/10/23.
//

import Foundation

struct Api_SubCategory : Codable {
    let result : [Res_SubCategory]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_SubCategory].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_SubCategory : Codable {
    let id : String?
    let category_id : String?
    let name : String?
    let name_fr : String?
    let image : String?
    let display_order : String?
    let remove_status : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case category_id = "category_id"
        case name = "name"
        case name_fr = "name_fr"
        case image = "image"
        case display_order = "display_order"
        case remove_status = "remove_status"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_fr = try values.decodeIfPresent(String.self, forKey: .name_fr)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        display_order = try values.decodeIfPresent(String.self, forKey: .display_order)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
