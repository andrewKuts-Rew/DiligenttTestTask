//
//  ViewModel.swift
//  Diligent
//
//  Created by Andrew Kuts on 2022-10-24.
//

import Foundation

protocol ViewModelProtocol: AnyObject {

    var selectedIndex: Int { get }
    var segmentControlItems: [String] { get }
    var sizeProvider: SizeProvider { get }

    func getColorName(forIndex index: Int) -> String?
    func getShowPath(forPoints points: [CGPoint]) -> PathModel
}

class ViewModel: ViewModelProtocol {

    var selectedIndex: Int
    let sizeProvider: SizeProvider
    let availableInteraction: [UserInteractionType]
    let segmentControlItems: [String]

    init(
        sizeProvider: SizeProvider,
        availableInteraction: [UserInteractionType] = [
            .draw(color: .red),
            .draw(color: .blue),
            .draw(color: .green),
            .erase
        ],
        selectedIndex: Int = 0
    ) {
        self.sizeProvider = sizeProvider
        self.availableInteraction = availableInteraction
        self.segmentControlItems = availableInteraction.map { $0.description }
        self.selectedIndex = selectedIndex
    }

    func getColorName(forIndex index: Int) -> String? {
        guard segmentControlItems.count >= index else {
            return nil
        }

        selectedIndex = index
        return availableInteraction[index].colorName
    }

    func getShowPath(forPoints points: [CGPoint]) -> PathModel {
        let userInteraction = availableInteraction[selectedIndex]

        return PathModel(
            delay: userInteraction.delay,
            colorName: userInteraction.colorName,
            points: points
        )
    }
}
