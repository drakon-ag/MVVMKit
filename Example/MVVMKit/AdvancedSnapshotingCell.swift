// 
//  AdvancedSnapshotingCell.swift
//  MVVMKit_Example
//
//  Created by Alfonso Grillo on 26/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import MVVMKit

@available(iOS 14.0, *)
struct AdvancedSnapshotingCellViewModel: ReusableViewViewModel {
    let identifier: String = .init(describing: AdvancedSnapshotingCell.self)

    let text: String
    let isExpandable: Bool
}

@available(iOS 14.0, *)
final class AdvancedSnapshotingCell: UICollectionViewListCell, CustomBinder {
    func bind(viewModel: AdvancedSnapshotingCellViewModel) {
        var content = defaultContentConfiguration()
        accessories = viewModel.isExpandable ? [.outlineDisclosure()] : []
        content.text = viewModel.text
        contentConfiguration = content
    }
}
