//
//  AppDelegate.swift
//  Instagram
//
//  Created by Victoria Nosik on 20.01.2022.
//

import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
//        Add dummy notification for current user
//        let id = NotificationsManager.newIdentifier()
//        let model = IGNotification(identifier: id,
//                                   notificationType: 3,
//                                   profilePictureUrl: "https://images.unsplash.com/photo-1645045702067-7b2ea69c82a8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80",
//                                   username: "joebiden",
//                                   dateString: String.date(from: Date()) ?? "Now",
//                                   isFollowing: true,
//                                   postId: nil,
//                                   postUrl: nil)
//        NotificationsManager.shared.create(notification: model, for: "vika")

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

