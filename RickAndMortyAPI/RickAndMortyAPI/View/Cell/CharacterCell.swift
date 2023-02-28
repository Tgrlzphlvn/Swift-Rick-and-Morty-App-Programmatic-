//
//  CharacterCollectionViewCell.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import UIKit
import SDWebImage

private protocol CharacterCollectionViewCellInterface {
    func configureCell()
    func imageConfig()
    func nameLabelConfig()
    func configure(model: Character)
}

class CharacterCell: UICollectionViewCell {
    
    static let identifier = "CharacterCollectionViewCell"

    private var imageView: UIImageView!
    private var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        imageConfig()
        nameLabelConfig()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
}


extension CharacterCell: CharacterCollectionViewCellInterface {
    
    func configure(model: Character) {
        imageView.sd_setImage(with: URL(string: model.image ?? ConstantStrings.emptyString))
        nameLabel.text = model.name ?? ConstantStrings.nullString
    }
    
    fileprivate func configureCell() {
        backgroundColor = .systemBackground
    }

    fileprivate func imageConfig() {
        imageView = UIImageView()
        addSubview(imageView)
        
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            imageView.widthAnchor.constraint(equalToConstant: 125),
            imageView.heightAnchor.constraint(equalToConstant: 175)
        ])

    }
    
    fileprivate func nameLabelConfig() {
        nameLabel = UILabel()
        addSubview(nameLabel)
        
        nameLabel.configureRegularLabel(fontSize: 14, color: .label, text: "")
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24),
            nameLabel.widthAnchor.constraint(equalToConstant: CGFloat.dWidth * 0.3),
        ])
    }
}
