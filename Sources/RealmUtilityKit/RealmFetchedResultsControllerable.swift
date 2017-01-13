//
//  RealmFetchedResultsControllerable.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/12/15.
//
//

import Foundation
import RealmSwift

public protocol RealmFetchedResultsControllerable {
    associatedtype Entity: RealmSwift.Object
    var fetchRequest: RealmFetchRequest<Entity> { get }
    var dynamicSections: [RealmFetchedResultsSection<Entity>]? { get }
    var dynamicSectionGenerator: RealmDynamicSectionGeneratorable? { get }
    var results: Results<Entity>! { get }
    init(fetchRequest: RealmFetchRequest<Entity>, dynamicSectionGenerator: RealmDynamicSectionGeneratorable?)
    func performFetch() throws
    func object(at indexPath: IndexPath) -> Entity
    func indexPath(forObject object: Entity, inSection section: Int?) -> IndexPath?
    subscript(indexPath: IndexPath) -> Entity { get }
}
