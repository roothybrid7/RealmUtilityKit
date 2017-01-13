//
//  RealmFetchedResultsController.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/12/15.
//
//

import Foundation
import RealmSwift

fileprivate struct PredicateTemplate {
    static let attrKey = "attrKey"
    static let valueKey = "VALUE"
    static let equals = NSPredicate(format: "$\(attrKey) == $\(valueKey)")
}

open class RealmFetchedResultsController<ResultType: RealmSwift.Object>: RealmFetchedResultsControllerable {
    public typealias Entity = ResultType

    public fileprivate(set) var fetchRequest: RealmFetchRequest<ResultType>
    public fileprivate(set) var dynamicSections: [RealmFetchedResultsSection<ResultType>]?
    public fileprivate(set) var dynamicSectionGenerator: RealmDynamicSectionGeneratorable?
    public fileprivate(set) var results: Results<ResultType>!

    public required init(fetchRequest: RealmFetchRequest<ResultType>, dynamicSectionGenerator: RealmDynamicSectionGeneratorable? = nil) {
        self.fetchRequest = fetchRequest
        self.dynamicSectionGenerator = dynamicSectionGenerator
    }

    public func performFetch() throws {
        results = try fetchRequest.execute()

        guard let dynamicSectionGenerator = dynamicSectionGenerator else { return }
        var sectionValues = results.value(forKeyPath: dynamicSectionGenerator.keyPath) as? [Any] ?? []
        sectionValues = NSSet(array: sectionValues).allObjects
        if let sortDescriptor = dynamicSectionGenerator.sortDescriptor {
            sectionValues = (sectionValues as NSArray).sortedArray(using: [sortDescriptor])
        }
        dynamicSections = sectionValues.map {
            RealmFetchedResultsSection(
                name: dynamicSectionGenerator.nameConverter($0),
                results: results.filter(
                    PredicateTemplate.equals.withSubstitutionVariables([
                        PredicateTemplate.attrKey: dynamicSectionGenerator.keyPath,
                        PredicateTemplate.valueKey: $0]))
            )
        }
    }

    public func object(at indexPath: IndexPath) -> ResultType {
        let index = indexPath.item == NSNotFound ? indexPath.row : indexPath.item
        guard let dynamicSections = dynamicSections else { return results[index] }
        let sectionInfo = dynamicSections[indexPath.section]
        return sectionInfo.results[index]
    }

    public func indexPath(forObject object: ResultType, inSection section: Int? = 0) -> IndexPath? {
        guard let section = section else { return nil }
        guard let dynamicSections = dynamicSections else {
            guard let index = results.index(of: object) else {
                return nil
            }
            return IndexPath(row: index, section: section)
        }
        if dynamicSections.count <= section {
            return nil
        }
        for (sectionIndex, sectionInfo) in dynamicSections.enumerated() {
            guard let index = sectionInfo.results.index(of: object) else { continue }
            return IndexPath(row: index, section: sectionIndex)
        }
        return nil
    }

    public subscript(indexPath: IndexPath) -> ResultType {
        return object(at: indexPath)
    }
}
