//
//  UserInteractionType.swift
//  Diligent
//
//  Created by Andrew Kuts on 2022-10-24.
//

enum UserInteractionType {

    case draw(color: AppColors)
    case erase

    var description: String {
        switch self {
        case .draw(color: let color):
            return color.name
        case .erase:
            return "Eraser"
        }
    }

    var colorName: String {
        switch self {
        case .draw(color: let color):
            return color.rawValue
        case .erase:
            return "appWhite"
        }
    }

    var delay: Int {
        switch self {
        case .draw(color: let color):
            switch color {
            case .red:
                return 1
            case .green:
                return 5
            case .blue:
                return 3
            }
        case .erase:
            return 2
        }
    }
}
