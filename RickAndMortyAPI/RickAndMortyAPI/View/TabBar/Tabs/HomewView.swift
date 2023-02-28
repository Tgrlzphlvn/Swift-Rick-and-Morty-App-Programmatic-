//
//  HomewView.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func homeViewConfigure()
    func collectionViewConfigure()
    func reloadCollectionView()
    func navigateToDetailView(character: Character)
}

final class HomewView: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        
        let date = Date()
        let fr = DateFormatter()
        
        fr.dateFormat = "d.MM.yyyy HH:mm"
        print(fr.string(from: date))
        
    }

}


extension HomewView: HomeViewInterface {
    
    func homeViewConfigure() {
        view.backgroundColor = .systemBackground
    }
    
    func collectionViewConfigure() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
    
    func navigateToDetailView(character: Character) {
        DispatchQueue.main.async {
            let detailView = CharacterDetailView(character: character)
            self.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}


extension HomewView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell
            else { return UICollectionViewCell()
        }
        
        cell.configure(model: viewModel.characters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigateToDetailView(character: viewModel.characters[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height) {
            viewModel.getCharacters()
        }
    }
}
