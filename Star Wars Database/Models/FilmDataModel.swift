//
//  FilmDataModel.swift
//  Star Wars Database
//
//  Created by MCOMM00008 on 06/05/23.
//

import Foundation

struct ResponseFilmDataModel: Codable {
    var title: String?
    var episode_id: Int?
    var opening_crawl: String?
    var director: String?
    var producer: String?
    var release_date: String?
    var characters: [String]?
    var planets: [String]?
    var starships: [String]?
    var vehicles: [String]?
    var species: [String]?
    var created: String?
    var edited: String?
    var url: String?
}

struct FilmDataModel {
    var id: Int
    var data: ResponseFilmDataModel?
}
