//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Tuğrul Özpehlivan on 16.02.2023.
//

import UIKit

private protocol TabBarViewInterface {
    func configureTabs()
}

final class TabBarView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
}


extension TabBarView: TabBarViewInterface {
    
    fileprivate func configureTabs() {
        tabBar.backgroundColor = .systemBackground
        
        let homeView = HomewView()
        let locationView = LocationView()
        let episodeView = EpisodeView()
        let settingsView = SearchView()
        
        homeView.title = "Rick and Morty"
        locationView.title = "Locations"
        episodeView.title = "Episodes"
        settingsView.title = "Search"
                
        homeView.navigationItem.largeTitleDisplayMode = .always
        locationView.navigationItem.largeTitleDisplayMode = .always
        episodeView.navigationItem.largeTitleDisplayMode = .always
        settingsView.navigationItem.largeTitleDisplayMode = .always
        
        let homeNav = UINavigationController(rootViewController: homeView)
        let locationNav = UINavigationController(rootViewController: locationView)
        let episodeNav = UINavigationController(rootViewController: episodeView)
        let settingsNav = UINavigationController(rootViewController: settingsView)
        
        homeNav.navigationBar.tintColor = .label
        locationNav.navigationBar.tintColor = .label
        episodeNav.navigationBar.tintColor = .label
        settingsNav.navigationBar.tintColor = .label
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        locationNav.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "location"), tag: 1)
        episodeNav.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "film"), tag: 1)
        settingsNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        setViewControllers([homeNav, locationNav, episodeNav, settingsNav], animated: true)
    }
}
