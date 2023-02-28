//
//  HomeViewModel.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidLoad()
    func getCharacters()
}


final class HomeViewModel {
    weak var view: HomeViewInterface?
    
    var characters = [Character]()
    private var page: Int = 1
}


extension HomeViewModel: HomeViewModelInterface {
    
    func viewDidLoad() {
        getCharacters()
        view?.homeViewConfigure()
        view?.collectionViewConfigure()
        view?.reloadCollectionView()
    }
    
    func getCharacters() {
        APIManager.shared.getAllCharacters(page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.characters.append(contentsOf: model.results ?? [])
                    self?.page += 1
                    self?.view?.reloadCollectionView()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
