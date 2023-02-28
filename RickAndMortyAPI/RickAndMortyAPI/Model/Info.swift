//
//  Info.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import Foundation

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next, prev: String?
}
