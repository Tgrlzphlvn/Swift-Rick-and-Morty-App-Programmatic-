//
//  Locations.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import Foundation



// MARK: - Location Result
struct LocationResult: Codable {
    let results: [Locations]?
}

// MARK: - Result
struct Locations: Codable {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}
