//
//  EntityValueAccessible.swift
//  RealmUtilityKit
//
//  Created by SATOSHI OHKI on 1/13/17.
//
//

import Foundation
import RealmSwift

public protocol EntityValueAccessible {
    /// A entity object name.
    static var objectName: String { get }
    /// Returns all Realm stored properties using such as a class sharedSchema.
    static var storedAllPropertyNames: [String] { get }
    /// Returns a dictionary containing the all realm stored property values.
    var dictionaryStoredAllProperties: [String: Any] { get }
    func dictionaryStoredAllProperties(without keys: [String]) -> [String: Any]
}

public extension EntityValueAccessible where Self: RealmSwift.Object {

    static var objectName: String {
        assert(self !== RealmSwift.Object.self)
        return className()
    }

    public static var storedAllPropertyNames: [String] {
        guard let schema = Self.sharedSchema() else { return [] }
        return schema.properties.filter { $0.objectClassName == nil }.map { $0.name }
    }

    var dictionaryStoredAllProperties: [String: Any] {
        return dictionaryWithValues(forKeys: type(of: self).storedAllPropertyNames)
    }

    func dictionaryStoredAllProperties(without keys: [String]) -> [String: Any] {
        let allKeys = type(of: self).storedAllPropertyNames.filter { keys.contains($0) == false }
        return dictionaryWithValues(forKeys: allKeys)
    }
}
