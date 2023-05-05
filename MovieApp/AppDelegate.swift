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
        
        presentViewController()
        
        return true
    }
    
    private func presentViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = MovieListViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }


}

