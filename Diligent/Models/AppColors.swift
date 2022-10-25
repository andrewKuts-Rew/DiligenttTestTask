//
//  AppColors.swift
//  Diligent
//
//  Created by Andrew Kuts on 2022-10-24.
//

enum AppColors: String {

    case red = "appRed"
    case green = "appGreen"
    case blue = "appBlue"

    var name: String {
        switch self {
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .blue:
            return "Blue"
        }
    }
}
