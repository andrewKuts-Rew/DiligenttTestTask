//
//  SceneDelegate.swift
//  Diligent
//
//  Created by Andrew Kuts on 2022-10-24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var sizeProvider: SizeProvider?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        setupWindow(scene)
    }
}

private extension SceneDelegate {

    func setupWindow(_ scene: UIScene) {
        guard let scene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: scene)
        let sizeProvider = AppSizeProvider.parse(window)
        let viewModel = ViewModel(sizeProvider: sizeProvider)
        window.rootViewController = ViewController(viewModel: viewModel)
        window.makeKeyAndVisible()

        self.sizeProvider = sizeProvider
        self.window = window
    }
}
