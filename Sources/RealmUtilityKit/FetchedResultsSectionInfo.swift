//
//  FetchedResultsSectionInfo.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/12/24.
//
//

import Foundation
import RealmSwift

public protocol FetchedResultsSectionInfo {
    associatedtype Entity: RealmSwift.Object
    var name: String { get }
    var results: Results<Entity> { get }
}

public final class FetchedResultsSection<ResultType: RealmSwift.Object>: FetchedResultsSectionInfo {
    public typealias Entity = ResultType

    public let name: String
    public let results: Results<ResultType>

    init(name: String, results: Results<ResultType>) {
        self.name = name
        self.results = results
    }
}
