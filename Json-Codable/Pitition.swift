//
//  Pitition.swift
//  Json-Codable
//
//  Created by Mahmoud Nasser on 30/11/2020.
//

import Foundation

struct Petitions: Codable {
    var results: [Petition]
}

struct Petition :Codable {
    var id : String
    var type: String
    var title :String
    var body :String
    var signatureCount:Int
}
