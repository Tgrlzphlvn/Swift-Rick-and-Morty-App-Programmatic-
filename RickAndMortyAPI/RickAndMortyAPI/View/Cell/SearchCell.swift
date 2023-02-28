//
//  SearchCell.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 27.02.2023.
//

import UIKit

private protocol SearchCellInteface {
    func configure(name: String, type: SearchItemTypeEnum)
    func configureCell()
    func nameLabelConfigure()
    func typeLabelConfigure()
}

class SearchCell: UICollectionViewCell {
    
    static let identifier = "SearchCell"
    
    private var nameLabel: UILabel!
    private var typeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        nameLabelConfigure()
        typeLabelConfigure()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

extension SearchCell: SearchCellInteface {

    func configure(name: String, type: SearchItemTypeEnum) {
        nameLabel.text = name
        typeLabel.text = type.rawValue
    }
    
    fileprivate func configureCell() {
        backgroundColor = .systemBackground
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    fileprivate func nameLabelConfigure() {
        nameLabel = UILabel()
        addSubview(nameLabel)
        
        nameLabel.configureBoldLabel(fontSize: 16, color: .label, text: ConstantStrings.nullString)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    fileprivate func typeLabelConfigure() {
        typeLabel = UILabel()
        addSubview(typeLabel)
        
        typeLabel.configureRegularLabel(fontSize: 14, color: .label, text: ConstantStrings.nullString)
        
        NSLayoutConstraint.activate([
            typeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            typeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
