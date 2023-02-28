//
//  LocationViewModel.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 18.02.2023.
//

import Foundation

protocol LocationViewModelInterface {
    var view: LocationViewInterface? { get set }
    var page: Int { get set }
    func viewDidLoad()
    func getLocations()
}


final class LocationViewModel {
    weak var view: LocationViewInterface?
    
    var locations = [Locations]()
    var page: Int = 1
}


extension LocationViewModel: LocationViewModelInterface {
    
    func viewDidLoad() {
        getLocations()
        view?.locationViewConfigure()
        view?.configureCollectionView()
        view?.reloadCollectionView()
    }
    
    func getLocations() {
        APIManager.shared.getAllLocations(page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.locations.append(contentsOf: model)
                    self?.page += 1
                    self?.view?.reloadCollectionView()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
