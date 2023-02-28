//
//  CharacterFeatureCard.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 21.02.2023.
//

import UIKit


private protocol CharacterFeatureCardInterface {
    func configure(characterType: CharacterEnum, mainLabel: String, infoLabel: String)
    func configureView()
    func configureSecondView()
    func configureMainLabel()
    func configureInfoLabel()
}


final class CharacterFeatureCell: UICollectionViewCell {
    
    static let identifier = "CharacterFeatureCell"
    
    private var secondView: UIView!
    private var mainLabel: UILabel!
    private var infoLabel: UILabel!
    private var cardLogo: UIImageView!
    
    var characterType: CharacterEnum?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSecondView()
        configureMainLabel()
        configureInfoLabel()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}

extension CharacterFeatureCell: CharacterFeatureCardInterface {

    func configure(characterType: CharacterEnum, mainLabel: String, infoLabel: String) {
        self.characterType = characterType
        self.mainLabel.text = mainLabel
        self.infoLabel.text = infoLabel
        
        switch characterType {
        case .name:
            secondView.backgroundColor = .secondaryLabel
        case .species:
            secondView.backgroundColor = .purple
        case .status:
            secondView.backgroundColor = .green
        case .gender:
            secondView.backgroundColor = .systemPink
        case .location:
            secondView.backgroundColor = .cyan
        case .created:
            secondView.backgroundColor = .brown
        case .episodes:
            secondView.backgroundColor = .orange
        }
    }
    
    fileprivate func configureView() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        self.clipsToBounds = true
    }
    
    fileprivate func configureSecondView() {
        secondView = UIView()
        addSubview(secondView)
        
        secondView.clipsToBounds = true
        
        secondView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondView.leftAnchor.constraint(equalTo: self.leftAnchor),
            secondView.rightAnchor.constraint(equalTo: self.rightAnchor),
            secondView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            secondView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    fileprivate func configureMainLabel() {
        mainLabel = UILabel()
        addSubview(mainLabel)
        
        mainLabel.configureRegularLabel(fontSize: 18, color: .label, text: ConstantStrings.nullString)
        mainLabel.numberOfLines = 3
        mainLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            mainLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    fileprivate func configureInfoLabel() {
        infoLabel = UILabel()
        addSubview(infoLabel)
        
        infoLabel.configureBoldLabel(fontSize: 16, color: .label, text: ConstantStrings.nullString)
        
        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: secondView.topAnchor, constant: 35),
            infoLabel.centerXAnchor.constraint(equalTo: secondView.centerXAnchor)
        ])
    }
}
