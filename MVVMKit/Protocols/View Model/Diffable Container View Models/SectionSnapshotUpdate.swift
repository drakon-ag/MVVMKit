/*
 SectionSnapshotUpdate.swift

 Copyright (c) 2020 Alfonso Grillo

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

/**
 A container for a NSDiffableDataSourceSectionSnapshot.
 This container describe the section related to the snapshot, if the diffing of a snapshot should be animated and provides a diffing completion.
 */
@available(iOS 14.0, *)
public struct SectionSnapshotUpdate<SectionType: Hashable, ItemType: Hashable> {
    public let snapshot: NSDiffableDataSourceSectionSnapshot<ItemType>
    public let section: SectionType
    public let animated: Bool
    public let completion: (() -> Void)?

    public init(
        snapshot: NSDiffableDataSourceSectionSnapshot<ItemType> = .init(),
        section: SectionType,
        animated: Bool = true,
        completion: (() -> Void)? = nil) {

        self.snapshot = snapshot
        self.section = section
        self.animated = animated
        self.completion = completion
    }
}

@available(iOS 14.0, *)
public extension NSDiffableDataSourceSectionSnapshot {
    func adapted<SectionType: Hashable>(section: SectionType,
                                        animated: Bool = true,
                                        completion: (() -> Void)? = nil) -> SectionSnapshotUpdate<SectionType, ItemIdentifierType> {
        .init(snapshot: self, section: section, animated: animated, completion: completion)
    }
}
