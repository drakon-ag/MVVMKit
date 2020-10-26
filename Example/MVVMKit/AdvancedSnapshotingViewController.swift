// 
//  AdvancedSnapshotingViewController.swift
//  MVVMKit_Example
//
//  Created by Alfonso Grillo on 26/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Combine
import MVVMKit

@available(iOS 14.0, *)
final class AdvancedSnapshotingViewController: MVVMDiffableCollectionViewController<AdvancedSnapshotingViewModel> {

    private var subscriptions: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        updateLayout()
        viewModel.loadContent()
    }

    private func setupCollectionView() {
        collectionView.register(SimpleCell.nib, forCellWithReuseIdentifier: SimpleCell.identifier)
    }
}

private extension NSCollectionLayoutSection {
    static func listSection(columns: Int = 1) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [])

        let insetValue: CGFloat = 3
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
        group.interItemSpacing = .fixed(insetValue)
        group.contentInsets = .init(top: 0, leading: insetValue, bottom: 0, trailing: insetValue)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = insetValue
        section.contentInsets = .init(top: insetValue, leading: 0, bottom: insetValue, trailing: 0)
        return section
    }
}

// MARK: Layout

@available(iOS 14.0, *)
extension AdvancedSnapshotingViewModel.Section: SectionLayoutConvertible {
    func sectionLayout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        switch self {
        case .main:
            return .listSection(columns: 1)
        case .second:
            return .listSection(columns: 2)
        }
    }
}
