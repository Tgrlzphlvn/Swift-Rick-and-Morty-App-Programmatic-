//
//  LocationCell.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 22.02.2023.
//

import UIKit

private protocol LocationCellInterface {
    func configure(name: String, type: String, dimension: String)
    func configureCell()
    func nameLabelConfigure()
    func typeLabelConfigure()
    func dimensionLabelConfigure()
    func forwardIconConfigure()
}

class LocationCell: UICollectionViewCell {
    
    static let identifier = "LocationCell"
    
    private var nameLabel: UILabel!
    private var typeLabel: UILabel!
    private var dimensionLabel: UILabel!
    private var forwardIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        nameLabelConfigure()
        typeLabelConfigure()
        dimensionLabelConfigure()
        forwardIconConfigure()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        typeLabel.text = nil
        dimensionLabel.text = nil
    }
}

extension LocationCell: LocationCellInterface {
    
    func configure(name: String, type: String, dimension: String) {
        nameLabel.text = name
        typeLabel.text = type
        dimensionLabel.text = dimension
    }
    
    fileprivate func configureCell() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    fileprivate func nameLabelConfigure() {
        nameLabel = UILabel()
        addSubview(nameLabel)
        
        nameLabel.configureBoldLabel(fontSize: 18, color: .label, text: ConstantStrings.nullString)
        nameLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
    }
    
    fileprivate func typeLabelConfigure() {
        typeLabel = UILabel()
        addSubview(typeLabel)
        
        typeLabel.configureRegularLabel(fontSize: 14, color: .label, text: ConstantStrings.nullString)
        typeLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
    
    fileprivate func dimensionLabelConfigure() {
        dimensionLabel = UILabel()
        addSubview(dimensionLabel)
        
        dimensionLabel.configureRegularLabel(fontSize: 14, color: .label, text: ConstantStrings.nullString)
        dimensionLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            dimensionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
    
    fileprivate func forwardIconConfigure() {
        forwardIcon = UIImageView(frame: .zero)
        addSubview(forwardIcon)
        
        forwardIcon.image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        forwardIcon.tintColor = .label
        
        forwardIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forwardIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            forwardIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
