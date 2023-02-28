//
//  URLManager.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import Foundation


class URLManager {
    static let shared = URLManager()
    
    private init() {}
    
    let mainURL = "https://rickandmortyapi.com/api"
    let characters = "https://rickandmortyapi.com/api/character"
    let locations = "https://rickandmortyapi.com/api/location"
    let episodes = "https://rickandmortyapi.com/api/episode"
}
