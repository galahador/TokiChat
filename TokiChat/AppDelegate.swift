//
//  AppDelegate.swift
//  TokiChat
//
//  Created by Petar Lemajic on 8/24/18.
//  Copyright © 2018 Metalic_archaea. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        setupNavigationBar()
        IQKeyboardManager.shared().isEnabled = true
        return true
    }
    
    fileprivate func setupNavigationBar() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
    }
}
