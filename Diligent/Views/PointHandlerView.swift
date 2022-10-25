//
//  PointHandlerView.swift
//  Diligent
//
//  Created by Andrew Kuts on 2022-10-24.
//

import UIKit

protocol PointDrawer: AnyObject {
    init(drawHandler: @escaping ([CGPoint]) -> Void)
}

class PointHandlerView: UIView, PointDrawer {

    private let drawHandler: ([CGPoint]) -> Void
    private var tmpPoints: [CGPoint] = []

    required init(drawHandler: @escaping ([CGPoint]) -> Void) {
        self.drawHandler = drawHandler
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let startLocation = touches.first?.location(in: self) {
            tmpPoints.append(startLocation)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let moveLocation = touches.first?.location(in: self) {
            tmpPoints.append(moveLocation)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let lastLocation = touches.first?.location(in: self) {
            tmpPoints.append(lastLocation)
        }

        drawHandler(tmpPoints)
        tmpPoints.removeAll()
    }
}
