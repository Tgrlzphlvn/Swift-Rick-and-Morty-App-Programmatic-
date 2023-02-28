//
//  UIHelper.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 18.02.2023.
//

import UIKit


enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = CGFloat.dWidth
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth * 0.32, height: itemWidth * 0.5)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        return layout
    }
    
    static func createCharacterDetailFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = CGFloat.dWidth
        let itemHeight = CGFloat.dHeight
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth * 0.47, height: itemHeight * 0.18)
        layout.minimumLineSpacing = 6
        
        return layout
    }
    
    static func createLocationFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = CGFloat.dWidth
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth * 0.98, height: 100)
        layout.minimumLineSpacing = 8
        
        return layout
    }
    
    static func searchFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = CGFloat.dWidth
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth * 0.9, height: 50)
        layout.minimumLineSpacing = 4
        
        return layout
    }
}
