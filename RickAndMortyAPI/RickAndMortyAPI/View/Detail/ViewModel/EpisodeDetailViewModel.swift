//
//  EpisodeDetailViewModel.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 24.02.2023.
//

import Foundation

protocol EpisodeDetailViewModelInterface {
    var view: EpisodeDetailViewInterface? { get set }
    
    func viewDidLoad()
    func getCharacters()
}

final class EpisodeDetailViewModel {
    weak var view: EpisodeDetailViewInterface?
    
    var characters = [Character]()
}

extension EpisodeDetailViewModel: EpisodeDetailViewModelInterface {
    
    func viewDidLoad() {
        getCharacters()
        view?.episodeDetailViewConfigure()
        view?.episodeInfoCardConfigure()
        view?.episodeCharactersLabelConfigure()
        view?.collectionViewConfigure()
    }
    
    func getCharacters() {
        guard let list = view?.episode?.characters else { return }
        var strings = ""
        for x in list {
            strings += "\(x.dropFirst(42)),"
        }
        if strings != "" {
            strings.removeLast()
        }
        print(strings)
        APIManager.shared.getMultipleCharacters(query: strings) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.characters.removeAll()
                    self?.characters = model
                    self?.view?.reloadCollectionView()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

    }
}
