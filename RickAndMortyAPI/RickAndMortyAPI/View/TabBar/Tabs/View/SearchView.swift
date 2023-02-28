//
//  SettingsView.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import UIKit
import Lottie


protocol SearchViewInterface: AnyObject {
    func settingsViewConfigure()
    func searchBarConfigure()
    func collectionViewConfigure()
    func reloadCollectionView()
}

final class SearchView: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    private var searchBar: UISearchBar!
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()

    }
}


extension SearchView: SearchViewInterface {

    func settingsViewConfigure() {
        view.backgroundColor = .systemBackground
    }
    
    func searchBarConfigure() {
        searchBar = UISearchBar()
        view.addSubview(searchBar)
        
        searchBar.delegate = self
        
        searchBar.barStyle = .default
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func collectionViewConfigure() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.searchFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 2),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        
    }
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
}

extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(params: searchText)
    }
}

extension SearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        
        let model = viewModel.searchList[indexPath.row]
        
        cell.configure(name: model.name ?? ConstantStrings.nullString , type: model.type ?? SearchItemTypeEnum.rickyBaby)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.searchList[indexPath.row].type {
        case .character:
            let vc = CharacterDetailView(character: viewModel.searchList[indexPath.row].character!)
            self.navigationController?.pushViewController(vc, animated: true)
        case .location:
            let vc = LocationDetailView(location: viewModel.searchList[indexPath.row].location!)
            self.navigationController?.pushViewController(vc, animated: true)
        case .episode:
            let vc = EpisodeDetailView(episode: viewModel.searchList[indexPath.row].episode!)
            self.navigationController?.pushViewController(vc, animated: true)
        case .rickyBaby:
            break
        default:
            break
        }
    }
}
