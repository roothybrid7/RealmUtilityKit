//
//  FetchRequest.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/12/15.
//
//

import Foundation
import RealmSwift

public protocol FetchRequestable {
    associatedtype Entity: RealmSwift.Object
    var predicate: NSPredicate? { get set }
    var container: Container { get set }
    var sortDescriptors: [SortDescriptor]? { get set }
    func execute() throws -> Results<Entity>
}

open class FetchRequest<ResultType: RealmSwift.Object>: FetchRequestable {
    public typealias Entity = ResultType

    public var predicate: NSPredicate?
    public var container: Container
    public var sortDescriptors: [SortDescriptor]?

    public init(container: Container) {
        self.container = container
    }

    public func execute() throws -> Results<ResultType> {
        let realm = try container.realm()
        var results = realm.objects(ResultType.self)
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        if let sortDescriptors = sortDescriptors {
            results = results.sorted(by: sortDescriptors)
        }
        return results
    }
}
