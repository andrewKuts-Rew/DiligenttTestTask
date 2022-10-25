//
//  DrawableView.swift
//  Diligent
//
//  Created by Andrew Kuts on 2022-10-24.
//

import UIKit

@MainActor
class DrawableView: UIView {

    private lazy var imageView = UIImageView()

    private var paths: PathModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        imageView.backgroundColor = .clear
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let paths = self.paths else { return }
        self.paths = nil

        UIGraphicsBeginImageContext(frame.size)

        guard
            let context = UIGraphicsGetCurrentContext(),
            let firstPoint = paths.points.first
        else {
            return
        }

        imageView.image?.draw(in: bounds)

        context.beginPath()
        context.move(to: firstPoint)
        for point in paths.points.dropFirst() {
            context.addLine(to: point)
        }
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(paths.lineWidth)
        if let color = UIColor(named: paths.colorName) {
            context.setStrokeColor(color.cgColor)
        }
        context.strokePath()

        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        imageView.alpha = paths.opacity
        UIGraphicsEndImageContext()
    }

    func drawPaths(_ paths: PathModel) {
        self.paths = paths
        self.setNeedsDisplay()
    }
}
