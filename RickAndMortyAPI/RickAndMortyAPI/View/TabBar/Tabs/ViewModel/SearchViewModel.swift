//
//  SettingsViewModel.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 18.02.2023.
//

import Foundation

protocol SearchViewModelInterface {
    var view: SearchViewInterface? { get set }
    func viewDidLoad()
    func search(params: String)
}


final class SearchViewModel {
    weak var view: SearchViewInterface?
    
    var searchList = [SearchModel]()
    
    private let characterViewModel = HomeViewModel()
    private let locationViewModel = LocationViewModel()
    private let episodeViewModel = EpisodeViewModel()
}


extension SearchViewModel: SearchViewModelInterface {
    
    func viewDidLoad() {
        view?.settingsViewConfigure()
        view?.searchBarConfigure()
        view?.collectionViewConfigure()
        view?.reloadCollectionView()
    }
    
    func search(params: String) {
        searchList.removeAll()
        
        APIManager.shared.filterCharacter(name: params) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    for i in model {
                        self?.searchList.append(SearchModel(name: i.name, url: i.url, type: .character, character: i, location: nil, episode: nil))
                    }
                    self?.view?.reloadCollectionView()
                    if params == "" {
                        self?.searchList.removeAll()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        APIManager.shared.filterLocations(name: params) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    for i in model {
                        self?.searchList.append(SearchModel(name: i.name, url: i.url, type: .location, character: nil, location: i, episode: nil))
                    }
                    self?.view?.reloadCollectionView()
                    if params == "" {
                        self?.searchList.removeAll()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

        APIManager.shared.filterEpisodes(name: params) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    for i in model {
                        self?.searchList.append(SearchModel(name: i.name, url: i.url, type: .episode, character: nil, location: nil, episode: i))
                    }
                    self?.view?.reloadCollectionView()
                    if params == "" {
                        self?.searchList.removeAll()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
