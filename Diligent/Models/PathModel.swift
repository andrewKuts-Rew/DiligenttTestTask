//
//  PathModel.swift
//  Diligent
//
//  Created by Andrew Kuts on 2022-10-24.
//

import CoreGraphics

struct PathModel {
    let delay: Int
    let opacity: CGFloat = 1.0
    let lineWidth: CGFloat = 5
    let colorName: String
    var points: [CGPoint]
}
