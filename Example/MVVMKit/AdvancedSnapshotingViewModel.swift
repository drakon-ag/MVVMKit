// 
//  AdvancedSnapshotingViewModel.swift
//  MVVMKit_Example
//
//  Created by Alfonso Grillo on 26/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Combine
import MVVMKit

@available(iOS 14.0, *)
final class AdvancedSnapshotingViewModel: DiffableCollectionViewViewModel {
    typealias SectionType = Section

    enum Section {
        case main
        case second
    }

    private let model: [String] = (1...10).map { _ in String.random(length: 10) }

    private let snapshotSubject: PassthroughSubject<SnapshotAdapter, Never> = .init()
    var snapshot: AnyPublisher<SnapshotAdapter, Never> {
        snapshotSubject.eraseToAnyPublisher()
    }

    private let sectionSnapshotSubject: PassthroughSubject<SectionSnapshotAdapter, Never> = .init()
    var sectionSnapshot: AnyPublisher<SectionSnapshotAdapter, Never> {
        sectionSnapshotSubject.eraseToAnyPublisher()
    }

    func loadContent() {
        var snapshot: NSDiffableDataSourceSnapshot<SectionType, ReusableViewViewModelAdapter> = .init()
        snapshot.appendSections([.main])
        snapshotSubject.send(snapshot.adapted())

        let viewModels = model.map {
            SimpleCellViewModel(text: $0)
                .adapted(hashable: $0)
        }

        // section snapshot
        let rootItem = viewModels.first!
        let others = Array(viewModels[1...])
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ReusableViewViewModelAdapter>()
        sectionSnapshot.append([rootItem])
        sectionSnapshot.append(others, to: rootItem)
        sectionSnapshotSubject.send(sectionSnapshot.adapted(section: .main))
        //
    }
}
