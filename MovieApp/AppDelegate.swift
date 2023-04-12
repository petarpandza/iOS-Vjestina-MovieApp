//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Petar on 23.03.2023..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        presentLogInViewController()
        
        return true
    }
    
    private func presentLogInViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = MovieListViewController()
        //let viewController = MovieCategoriesViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }


}

