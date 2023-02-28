//
//  UILabel+Ext.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 20.02.2023.
//

import UIKit


extension UILabel {
    func configureRegularLabel(fontSize: CGFloat, color: UIColor, text: String) {
        self.text = text
        self.font = .systemFont(ofSize: fontSize, weight: .regular)
        self.textColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureBoldLabel(fontSize: CGFloat, color: UIColor, text: String) {
        self.text = text
        self.font = .systemFont(ofSize: fontSize, weight: .bold)
        self.textColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
