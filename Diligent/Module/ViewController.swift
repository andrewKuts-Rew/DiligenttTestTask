//
//  ViewController.swift
//  Diligent
//
//  Created by Andrew Kuts on 2022-10-24.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel: ViewModelProtocol

    private lazy var controlView = UIView()
    private lazy var drawableView = DrawableView()
    private lazy var pointHandlerView = PointHandlerView(drawHandler: handlePoints)

    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension ViewController {

    func setupUI() {
        view.backgroundColor = .white
        setupColorControlUI()
        setupShowBoard()
        setupPointHandler()
    }

    // swiftlint:disable: line_length
    func setupColorControlUI() {
        view.addSubview(controlView)
        controlView.translatesAutoresizingMaskIntoConstraints = false
        controlView.topAnchor.constraint(equalTo: view.topAnchor, constant: viewModel.sizeProvider.safeAreaInsets.top).isActive = true
        controlView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controlView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controlView.backgroundColor = .white

        let segmentControl = UISegmentedControl(items: viewModel.segmentControlItems)
        controlView.addSubview(segmentControl)
        controlView.bottomAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: viewModel.sizeProvider.internalInset).isActive = true
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(selectColor), for: .valueChanged)
        segmentControl.topAnchor.constraint(equalTo: controlView.topAnchor, constant: viewModel.sizeProvider.internalInset).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: viewModel.sizeProvider.internalInset).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -viewModel.sizeProvider.internalInset).isActive = true
        segmentControl.selectedSegmentIndex = viewModel.selectedIndex

        if let colorName = viewModel.getColorName(forIndex: viewModel.selectedIndex), let color = UIColor(named: colorName) {
            segmentControl.selectedSegmentTintColor = color
        }
    }

    @objc
    func selectColor(_ sender: UISegmentedControl) {
        if let newColorName = viewModel.getColorName(forIndex: sender.selectedSegmentIndex), let color = UIColor(named: newColorName) {
            sender.selectedSegmentTintColor = color
        }
    }

    func setupPointHandler() {
        view.addSubview(pointHandlerView)
        pointHandlerView.translatesAutoresizingMaskIntoConstraints = false
        pointHandlerView.clipsToBounds = true
        pointHandlerView.topAnchor.constraint(equalTo: controlView.bottomAnchor, constant: viewModel.sizeProvider.internalInset).isActive = true
        pointHandlerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewModel.sizeProvider.internalInset).isActive = true
        pointHandlerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewModel.sizeProvider.internalInset).isActive = true
        pointHandlerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -viewModel.sizeProvider.internalInset).isActive = true
        pointHandlerView.backgroundColor = .clear
    }

    func setupShowBoard() {
        view.addSubview(drawableView)
        drawableView.translatesAutoresizingMaskIntoConstraints = false
        drawableView.clipsToBounds = true
        drawableView.topAnchor.constraint(equalTo: controlView.bottomAnchor, constant: viewModel.sizeProvider.internalInset).isActive = true
        drawableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewModel.sizeProvider.internalInset).isActive = true
        drawableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewModel.sizeProvider.internalInset).isActive = true
        drawableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -viewModel.sizeProvider.internalInset).isActive = true
        drawableView.layer.cornerRadius = viewModel.sizeProvider.cornerRadius
        drawableView.layer.borderWidth = viewModel.sizeProvider.borderWidth
        drawableView.layer.borderColor = UIColor.black.cgColor
        drawableView.backgroundColor = UIColor(named: UserInteractionType.erase.colorName)
    }

    func handlePoints(_ points: [CGPoint]) {
        let showModel = viewModel.getShowPath(forPoints: points)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(showModel.delay), execute: { [weak self] in
            self?.drawableView.drawPaths(showModel)
        })
    }
    // swiftlint:enable: line_length
}
