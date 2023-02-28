//
//  SearchModel.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 27.02.2023.
//

import Foundation


struct SearchModel {
    let name: String?
    let url: String?
    let type: SearchItemTypeEnum?
    let character: Character?
    let location: Locations?
    let episode: Episode?
}
