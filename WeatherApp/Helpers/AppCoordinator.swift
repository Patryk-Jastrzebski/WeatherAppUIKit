//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import UIKit

final class AppCoordinator {
    
    static let shared = AppCoordinator()
    
    weak var window: UIWindow?
    
    private init() { }
    
    func showFirstViewController() {
        let viewController = SearchScreenCreator().viewController
        setRootViewController(viewController)
    }
    
    private func setRootViewController(_ viewController: UIViewController, animated: Bool = false) {
        guard let window = window else {
            assertionFailure("window not set")
            return
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        if animated {
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionFlipFromRight,
                              animations: {})
        }
    }
}
