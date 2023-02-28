//
//  CharacterDetailViewModel.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 20.02.2023.
//

import Foundation


protocol CharacterDetailViewModelInterface {
    var view: CharacterDetailViewInterface? { get set }
    
    func viewDidLoad()
    func modelConverter()
}

final class CharacterDetailViewModel {
    weak var view: CharacterDetailViewInterface?
    
    var characterDetailModel = [CharacterDetailModel]()
}


extension CharacterDetailViewModel: CharacterDetailViewModelInterface {
    
    func viewDidLoad() {
        view?.configureCharacterDetailView()
        view?.imageConfingure()
        modelConverter()
        view?.collectionViewConfigure()
    }
    
    func modelConverter() {
        characterDetailModel.append(CharacterDetailModel(name: view?.character.name, info: "Name", type: .name))
        characterDetailModel.append(CharacterDetailModel(name: view?.character.gender, info: "Gender", type: .gender))
        characterDetailModel.append(CharacterDetailModel(name: view?.character.status, info: "Status", type: .status))
        characterDetailModel.append(CharacterDetailModel(name: view?.character.species, info: "Species", type: .species))
        characterDetailModel.append(CharacterDetailModel(name: view?.character.episode?.count.description, info: "Episode count", type: .episodes))
        characterDetailModel.append(CharacterDetailModel(name: view?.character.location?.name, info: "Location", type: .location))
        characterDetailModel.append(CharacterDetailModel(name: view?.character.created, info: "Created time", type: .created))
    }
}
