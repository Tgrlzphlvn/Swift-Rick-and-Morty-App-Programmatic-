//
//  EpisodeInfoCard.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 24.02.2023.
//

import UIKit

protocol EpisodeInfoCardInterface {
    func configure(name: String, date: String, episode: String)
    func episodeInfoCardConfigure()
    func nameLabelConfigure()
    func dateLabelConfigure()
    func episodeLabelConfigure()
}

class EpisodeInfoCard: UIView {
    
    private var nameLabel: UILabel!
    private var dateLabel: UILabel!
    private var episodeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        episodeInfoCardConfigure()
        nameLabelConfigure()
        episodeLabelConfigure()
        dateLabelConfigure()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}


extension EpisodeInfoCard: EpisodeInfoCardInterface {
    
    func configure(name: String, date: String, episode: String) {
        self.nameLabel.text = name
        self.dateLabel.text = date
        self.episodeLabel.text = episode
    }
    
    func episodeInfoCardConfigure() {
        backgroundColor = .systemBackground
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func nameLabelConfigure() {
        nameLabel = UILabel()
        addSubview(nameLabel)
        
        nameLabel.configureBoldLabel(fontSize: 18, color: .label, text: ConstantStrings.nullString)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
    
    func episodeLabelConfigure() {
        episodeLabel = UILabel()
        addSubview(episodeLabel)
        
        episodeLabel.configureRegularLabel(fontSize: 16, color: .label, text: ConstantStrings.nullString)
        
        NSLayoutConstraint.activate([
            episodeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            episodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
    
    func dateLabelConfigure() {
        dateLabel = UILabel()
        addSubview(dateLabel)
        
        dateLabel.configureRegularLabel(fontSize: 16, color: .label, text: ConstantStrings.nullString)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
}
