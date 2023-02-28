//
//  EpisodeDetailView.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 24.02.2023.
//

import UIKit

protocol EpisodeDetailViewInterface: AnyObject {
    var episode: Episode? { get set }
    
    func episodeDetailViewConfigure()
    func episodeInfoCardConfigure()
    func episodeCharactersLabelConfigure()
    func collectionViewConfigure()
    func reloadCollectionView()
    func navigateToCharacterDetailView(character: Character)
}

final class EpisodeDetailView: UIViewController {
    
    private var episodeInfoCard: EpisodeInfoCard!
    private var episodeCharactersLabel: UILabel!
    private var collectionView: UICollectionView!
    
    private let viewModel = EpisodeDetailViewModel()
    
    var episode: Episode?
    
    init(episode: Episode) {
        self.episode = episode
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

extension EpisodeDetailView: EpisodeDetailViewInterface {
    
    func episodeDetailViewConfigure() {
        view.backgroundColor = .systemBackground
    }
    
    func episodeInfoCardConfigure() {
        episodeInfoCard = EpisodeInfoCard()
        view.addSubview(episodeInfoCard)
        
        episodeInfoCard.configure(name: episode?.name ?? ConstantStrings.nullString, date: episode?.airDate ?? ConstantStrings.nullString, episode: episode?.episode ?? ConstantStrings.nullString)
        
        episodeInfoCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeInfoCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            episodeInfoCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            episodeInfoCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            episodeInfoCard.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func episodeCharactersLabelConfigure() {
        episodeCharactersLabel = UILabel()
        view.addSubview(episodeCharactersLabel)
        
        episodeCharactersLabel.configureBoldLabel(fontSize: 18, color: .label, text: ConstantStrings.episodeCaharacters)
        episodeCharactersLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            episodeCharactersLabel.topAnchor.constraint(equalTo: episodeInfoCard.bottomAnchor, constant: 10),
            episodeCharactersLabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            episodeCharactersLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func collectionViewConfigure() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: episodeCharactersLabel.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
    
    func navigateToCharacterDetailView(character: Character) {
        let detailView = CharacterDetailView(character: character)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

extension EpisodeDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            return UICollectionViewCell()
        }
        
        let model = viewModel.characters[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigateToCharacterDetailView(character: viewModel.characters[indexPath.row])
    }
}
