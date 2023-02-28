//
//  CharacterDetailView.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 20.02.2023.
//

import UIKit
import SDWebImage

protocol CharacterDetailViewInterface: AnyObject {
    var character: Character { get set }
    func configureCharacterDetailView()
    func imageConfingure()
    func collectionViewConfigure()
}

final class CharacterDetailView: UIViewController {
    
    private let viewModel = CharacterDetailViewModel()
    
    var character: Character
    
    private var image: UIImageView!
    private var collectionView: UICollectionView!

    
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }

}

extension CharacterDetailView: CharacterDetailViewInterface {
    
    func configureCharacterDetailView() {
        view.backgroundColor = .systemBackground
        
    }
    
    func imageConfingure() {
        image = UIImageView()
        image.sd_setImage(with: URL(string: character.image ?? ConstantStrings.emptyString))
        view.addSubview(image)
        
        image.contentMode = .scaleToFill
        
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leftAnchor.constraint(equalTo: view.leftAnchor),
            image.rightAnchor.constraint(equalTo: view.rightAnchor),
            image.heightAnchor.constraint(equalToConstant: CGFloat.dHeight * 0.3)
        ])
    }
    
    func collectionViewConfigure() {
        collectionView = UICollectionView(frame: .zero , collectionViewLayout: UIHelper.createCharacterDetailFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CharacterFeatureCell.self, forCellWithReuseIdentifier: CharacterFeatureCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 2),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CharacterDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characterDetailModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterFeatureCell.identifier, for: indexPath) as? CharacterFeatureCell else {
            return UICollectionViewCell()
        }
        
        let model = viewModel.characterDetailModel[indexPath.row]
        
        cell.configure(characterType: model.type ?? .name, mainLabel: model.name ?? ConstantStrings.nullString, infoLabel: model.info ?? ConstantStrings.nullString)
        return cell
    }
}
