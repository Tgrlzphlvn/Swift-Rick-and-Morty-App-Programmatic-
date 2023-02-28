//
//  EpisodeView.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import UIKit

protocol EpisodeViewInterface: AnyObject {
    func episodeViewConfigure()
    func collectionViewConfigure()
    func reloadCollectionView()
    func naviagateToDetailView(episode: Episode)
}

final class EpisodeView: UIViewController {
    
    private let viewModel = EpisodeViewModel()
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }

}

extension EpisodeView: EpisodeViewInterface {
    
    func episodeViewConfigure() {
        view.backgroundColor = .systemBackground
        
    }
    
    func collectionViewConfigure() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createLocationFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(LocationCell.self, forCellWithReuseIdentifier: LocationCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
    
    func naviagateToDetailView(episode: Episode) {
        DispatchQueue.main.async {
            let detailView = EpisodeDetailView(episode: episode)
            self.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

extension EpisodeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.identifier, for: indexPath) as? LocationCell else {
            return UICollectionViewCell()
        }
        let model = viewModel.episodes[indexPath.row]
        cell.configure(name: model.name ?? ConstantStrings.nullString, type: model.episode ?? ConstantStrings.nullString, dimension: model.airDate ?? ConstantStrings.nullString)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height) {
            viewModel.getEpisodes()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.naviagateToDetailView(episode: viewModel.episodes[indexPath.row])
    }
}
