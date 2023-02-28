//
//  LocationDetailView.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 22.02.2023.
//

import UIKit

protocol LocationDetailViewInterface: AnyObject {
    var location: Locations? { get set }
    
    func configureLocationDetailView()
    func nameCardConfigure()
    func typeCardConfigure()
    func dimensionCardConfigure()
    func createdCardConfigure()
    func locationCharactersLabelConfigure()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateToDetailView(character: Character)
}

class LocationDetailView: UIViewController {
    
    private let viewModel = LocationDetailViewModel()
    
    var location: Locations?
    
    private var nameCard: LocationInfoCard!
    private var typeCard: LocationInfoCard!
    private var dimensionCard: LocationInfoCard!
    private var createdCard: LocationInfoCard!
    private var locationCharactersLabel: UILabel!
    private var collectionView: UICollectionView!
    
    init(location: Locations) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()

    }
}


extension LocationDetailView: LocationDetailViewInterface {
    
    func configureLocationDetailView() {
        view.backgroundColor = .systemBackground
    }
    
    func nameCardConfigure() {
        nameCard = LocationInfoCard()
        view.addSubview(nameCard)
        
        
        nameCard.configure(name: location?.name ?? ConstantStrings.nullString, info: "Name")
        
        nameCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            nameCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameCard.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.47),
            nameCard.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.14)
        ])
    }
    
    func typeCardConfigure() {
        typeCard = LocationInfoCard()
        view.addSubview(typeCard)
        
        typeCard.configure(name: location?.type ?? ConstantStrings.nullString, info: "Type")
        
        typeCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            typeCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            typeCard.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.47),
            typeCard.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.14)
        ])
    }
    
    func dimensionCardConfigure() {
        dimensionCard = LocationInfoCard()
        view.addSubview(dimensionCard)
        
        dimensionCard.configure(name: location?.dimension ?? ConstantStrings.nullString, info: "Dimension")
        
        dimensionCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimensionCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            dimensionCard.topAnchor.constraint(equalTo: nameCard.bottomAnchor, constant: 8),
            dimensionCard.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.47),
            dimensionCard.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.14)
        ])
    }
    
    func createdCardConfigure() {
        createdCard = LocationInfoCard()
        view.addSubview(createdCard)
        
        createdCard.configure(name: location?.created ?? ConstantStrings.nullString, info: "Created time")
        
        createdCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createdCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            createdCard.topAnchor.constraint(equalTo: typeCard.bottomAnchor, constant: 8),
            createdCard.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.47),
            createdCard.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.14)
        ])
    }
    
    func locationCharactersLabelConfigure() {
        locationCharactersLabel = UILabel()
        view.addSubview(locationCharactersLabel)
        
        locationCharactersLabel.configureBoldLabel(fontSize: 18, color: .label, text: ConstantStrings.locationCharacters)
        locationCharactersLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            locationCharactersLabel.topAnchor.constraint(equalTo: createdCard.bottomAnchor, constant: 8),
            locationCharactersLabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            locationCharactersLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: locationCharactersLabel.bottomAnchor, constant: 2),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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


extension LocationDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        self.navigateToDetailView(character: viewModel.characters[indexPath.row])
    }
    
}
