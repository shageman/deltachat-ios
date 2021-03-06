//
//  AppCoordinator.swift
//  deltachat-ios
//
//  Created by Jonas Reinsch on 07.11.17.
//  Copyright © 2017 Jonas Reinsch. All rights reserved.
//

import UIKit

protocol Coordinator {
    func setupViewControllers(window: UIWindow)
}

class AppCoordinator: Coordinator {
    let tabBarController = UITabBarController()

    func setupViewControllers(window: UIWindow) {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.white
        
        let ud = UserDefaults.standard
        if ud.bool(forKey: Constants.Keys.deltachatUserProvidedCredentialsKey) {
            initCore(withCredentials: false)
            setupInnerViewControllers()
        } else {
//            let email = "alice@librechat.net"
//            let password = "foobar"
//            initCore(email: email, password: password)
            
            let credentialsController = CredentialsController()
            let credentialsNav = UINavigationController(rootViewController: credentialsController)

            tabBarController.present(credentialsNav, animated: false, completion: nil)
        }
    }
    
    func setupInnerViewControllers() {

        let contactViewController = ContactViewController(coordinator: self)
        let contactNavigationController = UINavigationController(rootViewController: contactViewController)
        
        let chatViewController = ChatListController()
        let chatNavigationController = UINavigationController(rootViewController: chatViewController)
        
        let settingsViewController = UIViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        settingsViewController.title = "Settings"
        settingsViewController.navigationController?.navigationBar.prefersLargeTitles = true
        
        let chatIcon = #imageLiteral(resourceName: "ic_chat_36pt").withRenderingMode(.alwaysTemplate)
        let contactsIcon = #imageLiteral(resourceName: "ic_people_36pt").withRenderingMode(.alwaysTemplate)
        let settingsIcon = #imageLiteral(resourceName: "ic_settings_36pt").withRenderingMode(.alwaysTemplate)
        
        let contactTabbarItem = UITabBarItem(title: "Contacts", image: contactsIcon, tag: 0)
        let chatTabbarItem = UITabBarItem(title: "Chats", image: chatIcon, tag: 1)
        let settingsTabbarItem = UITabBarItem(title: "Settings", image: settingsIcon, tag: 2)
        
        contactNavigationController.tabBarItem = contactTabbarItem
        chatNavigationController.tabBarItem = chatTabbarItem
        settingsNavigationController.tabBarItem = settingsTabbarItem
        
        tabBarController.viewControllers = [
//            contactNavigationController,
            chatNavigationController,
            settingsNavigationController,
        ]
    }
}
