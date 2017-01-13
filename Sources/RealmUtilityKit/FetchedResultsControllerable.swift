//
//  FetchedResultsControllerable.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/12/15.
//
//

import Foundation
import RealmSwift

public protocol FetchedResultsControllerable {
    associatedtype Entity: RealmSwift.Object
    var fetchRequest: FetchRequest<Entity> { get }
    var dynamicSections: [FetchedResultsSection<Entity>]? { get }
    var dynamicSectionGenerator: DynamicSectionGeneratorable? { get }
    var results: Results<Entity>! { get }
    init(fetchRequest: FetchRequest<Entity>, dynamicSectionGenerator: DynamicSectionGeneratorable?)
    func performFetch() throws
    func object(at indexPath: IndexPath) -> Entity
    func indexPath(forObject object: Entity, inSection section: Int?) -> IndexPath?
    subscript(indexPath: IndexPath) -> Entity { get }
}
