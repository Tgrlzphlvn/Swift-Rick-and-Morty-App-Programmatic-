//
//  EpisodeViewModel.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 18.02.2023.
//

import Foundation

protocol EpisodeViewModelInterface {
    var view: EpisodeViewInterface? { get set }
    
    func viewDidLoad()
    func getEpisodes()
}


final class EpisodeViewModel {
    weak var view: EpisodeViewInterface?
    
    var episodes = [Episode]()
    
    var page: Int = 1
}


extension EpisodeViewModel: EpisodeViewModelInterface {
    
    func viewDidLoad() {
        getEpisodes()
        view?.episodeViewConfigure()
        view?.collectionViewConfigure()
    }
    
    func getEpisodes() {
        APIManager.shared.getAllEpisodes(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.episodes.append(contentsOf: model)
                    self.page += 1
                    self.view?.reloadCollectionView()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
