//
//  Episodes.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import Foundation


// MARK: - Episodes
struct Episodes: Codable {
    let info: Info?
    let results: [Episode]?
}

// MARK: - Result
struct Episode: Codable {
    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
