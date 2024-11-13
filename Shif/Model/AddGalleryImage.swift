//
//  AddGalleryImage.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 30/10/23.
//

import Foundation

struct Api_AddGallaryImage : Codable {
    
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
