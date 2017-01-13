//
//  RealmFetchedResultsSectionInfo.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/12/24.
//
//

import Foundation
import RealmSwift

public protocol RealmFetchedResultsSectionInfo {
    associatedtype Entity: RealmSwift.Object
    var name: String { get }
    var results: Results<Entity> { get }
}

public final class RealmFetchedResultsSection<ResultType: RealmSwift.Object>: RealmFetchedResultsSectionInfo {
    public typealias Entity = ResultType

    public let name: String
    public let results: Results<ResultType>

    init(name: String, results: Results<ResultType>) {
        self.name = name
        self.results = results
    }
}
