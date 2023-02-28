//
//  SearchView.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import UIKit

protocol LocationViewInterface: AnyObject {
    func locationViewConfigure()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateToDetailView(location: Locations)
}

final class LocationView: UIViewController {
    
    private let viewModel = LocationViewModel()
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension LocationView: LocationViewInterface {
    
    func locationViewConfigure() {
        view.backgroundColor = .systemBackground
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createLocationFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LocationCell.self, forCellWithReuseIdentifier: LocationCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
    
    func navigateToDetailView(location: Locations) {
        DispatchQueue.main.async {
            let detailView = LocationDetailView(location: location)
            self.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

extension LocationView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.locations.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.identifier, for: indexPath) as? LocationCell else {
            return UICollectionViewCell()
        }
        let model = viewModel.locations[indexPath.row]
        cell.configure(name: model.name ?? ConstantStrings.nullString, type: model.type ?? ConstantStrings.nullString, dimension: model.dimension ?? ConstantStrings.nullString)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigateToDetailView(location: viewModel.locations[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height) {
            viewModel.getLocations()
        }
    }
    
}
