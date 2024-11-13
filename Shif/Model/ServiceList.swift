//
//  ServiceList.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 21/10/23.
//

import Foundation

struct Api_ServiceList : Codable {
    
    let result : [Res_ServiceList]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_ServiceList].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_ServiceList : Codable {
    let id : String?
    let user_id : String?
    let cat_id : String?
    let cat_name : String?
    let sub_cat_id : String?
    let sub_cat_name : String?
    let service_name : String?
    let description : String?
    let service_rate : String?
    let working_time : String?
    let image : String?
    let date_time : String?
    let remove_status : String?
    let admin_service_fee : String?
    let total_of_service_rate_fee : Int?
    let service_images : [List_Service_images]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case sub_cat_id = "sub_cat_id"
        case sub_cat_name = "sub_cat_name"
        case service_name = "service_name"
        case description = "description"
        case service_rate = "service_rate"
        case working_time = "working_time"
        case image = "image"
        case date_time = "date_time"
        case admin_service_fee = "admin_service_fee"
        case remove_status = "remove_status"
        case total_of_service_rate_fee = "total_of_service_rate_fee"
        case service_images = "service_images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        sub_cat_id = try values.decodeIfPresent(String.self, forKey: .sub_cat_id)
        sub_cat_name = try values.decodeIfPresent(String.self, forKey: .sub_cat_name)
        service_name = try values.decodeIfPresent(String.self, forKey: .service_name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        service_rate = try values.decodeIfPresent(String.self, forKey: .service_rate)
        working_time = try values.decodeIfPresent(String.self, forKey: .working_time)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        service_images = try values.decodeIfPresent([List_Service_images].self, forKey: .service_images)
        admin_service_fee = try values.decodeIfPresent(String.self, forKey: .admin_service_fee)
        total_of_service_rate_fee = try values.decodeIfPresent(Int.self, forKey: .total_of_service_rate_fee)
    }
}

struct List_Service_images : Codable {
    let id : String?
    let service_id : String?
    let image : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case service_id = "service_id"
        case image = "image"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        service_id = try values.decodeIfPresent(String.self, forKey: .service_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
