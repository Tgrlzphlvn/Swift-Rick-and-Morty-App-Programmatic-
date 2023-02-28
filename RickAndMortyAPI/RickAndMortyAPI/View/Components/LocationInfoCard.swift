//
//  LocationInfoCard.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 23.02.2023.
//

import UIKit

protocol LocationInfoCardInterface {
    func configure(name: String, info: String)
    func locationInfoCardConfgiure()
    func secondViewConfigure()
    func infoLabelConfigure()
    func nameLabelConfigure()
}

class LocationInfoCard: UIView {
    
    private var nameLabel: UILabel!
    private var infoLabel: UILabel!
    private var secondView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        locationInfoCardConfgiure()
        secondViewConfigure()
        infoLabelConfigure()
        nameLabelConfigure()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

extension LocationInfoCard: LocationInfoCardInterface {
    
    func configure(name: String, info: String) {
        self.nameLabel.text  = name
        self.infoLabel.text = info
    }
    
    func locationInfoCardConfgiure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
    func secondViewConfigure() {
        secondView = UIView()
        addSubview(secondView)
        
        secondView.backgroundColor = .systemYellow
        
        secondView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            secondView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            secondView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func infoLabelConfigure() {
        infoLabel = UILabel()
        addSubview(infoLabel)
        
        infoLabel.configureBoldLabel(fontSize: 16, color: .label, text: ConstantStrings.nullString)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 15)
        ])
    }
    
    func nameLabelConfigure() {
        nameLabel = UILabel()
        addSubview(nameLabel)
        
        nameLabel.configureRegularLabel(fontSize: 16, color: .label, text: ConstantStrings.nullString)
        
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            nameLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}
