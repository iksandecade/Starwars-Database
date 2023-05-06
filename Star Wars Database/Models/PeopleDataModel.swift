//
//  PeopleDataModel.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation

struct ResponsePeopleDataModel: Codable {
    var name: String?
    var height: String?
    var mass: String?
    var hair_color: String?
    var skin_color: String?
    var eye_color: String?
    var birth_year: String?
    var gender: String?
    var homeWorld: String?
    var films: [String]?
    var species: [String]?
    var vehicles: [String]?
    var startships: [String]?
    var created: String?
    var edited: String?
    var url: String?
}
