//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 15/03/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        AppCoordinator.shared.window = window
        AppCoordinator.shared.showFirstViewController()
    }
}
