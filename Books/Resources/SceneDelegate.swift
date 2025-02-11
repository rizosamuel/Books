//
//  SceneDelegate.swift
//  Books
//
//  Created by Rijo Samuel on 01/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let router = BooksRouter()
        window?.rootViewController = router.getRootViewController()
        window?.makeKeyAndVisible()
    }
}
