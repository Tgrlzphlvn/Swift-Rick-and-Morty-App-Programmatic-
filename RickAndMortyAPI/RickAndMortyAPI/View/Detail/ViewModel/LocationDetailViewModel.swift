//
//  LocationViewModel.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 22.02.2023.
//

import Foundation

protocol LocationDetailViewModelInterface {
    var view: LocationDetailViewInterface? { get set }
    
    func viewDidLoad()
    func getResidents()
}

final class LocationDetailViewModel {
    weak var view: LocationDetailViewInterface?
    
    var characters = [Character]()
}


extension LocationDetailViewModel: LocationDetailViewModelInterface {
    
    func viewDidLoad() {
        getResidents()
        view?.configureLocationDetailView()
        view?.nameCardConfigure()
        view?.typeCardConfigure()
        view?.dimensionCardConfigure()
        view?.createdCardConfigure()
        view?.locationCharactersLabelConfigure()
        view?.configureCollectionView()
    }
    
    func getResidents() {
        guard let list = view?.location?.residents else { return }
        var strings = ""
        for x in list {
            strings += "\(x.dropFirst(42)),"
        }
        if strings != "" {
            strings.removeLast()
        }
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
