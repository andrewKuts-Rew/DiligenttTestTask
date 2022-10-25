//
//  SizeProvider.swift
//  Diligent
//
//  Created by Andrew Kuts on 2022-10-24.
//

import UIKit

protocol SizeProvider {
    var shortInset: CGFloat { get }
    var internalInset: CGFloat { get }
    var controlHeight: CGFloat { get }
    var safeAreaInsets: UIEdgeInsets { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
}

struct AppSizeProvider: SizeProvider {
    var borderWidth: CGFloat = 2
    var cornerRadius: CGFloat = 30
    var controlHeight: CGFloat = 50
    var shortInset: CGFloat = 8
    var internalInset: CGFloat = 16
    var safeAreaInsets: UIEdgeInsets

    private init(
        controlHeight: CGFloat = 50,
        shortInset: CGFloat = 8,
        internalInset: CGFloat = 16,
        safeAreaInsets: UIEdgeInsets
    ) {
        self.controlHeight = controlHeight
        self.shortInset = shortInset
        self.internalInset = internalInset
        self.safeAreaInsets = safeAreaInsets
    }

    static func parse(_ window: UIWindow) -> SizeProvider {
        return AppSizeProvider(safeAreaInsets: window.safeAreaInsets)
    }
}
