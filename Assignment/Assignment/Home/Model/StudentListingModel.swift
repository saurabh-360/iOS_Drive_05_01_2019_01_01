//
//  StudentListingModel.swift
//  Assignment
//
//  Created by Saurabh Yadav on 05/01/19.
//  Copyright © 2019 Viacom 18. All rights reserved.
//

import Foundation



struct StudentListingModel : Codable {
    let gender : String?
    let age : Int?
    let id : Int?
    let rank : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case gender = "gender"
        case age = "age"
        case id = "id"
        case rank = "rank"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        rank = try values.decodeIfPresent(Int.self, forKey: .rank)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
