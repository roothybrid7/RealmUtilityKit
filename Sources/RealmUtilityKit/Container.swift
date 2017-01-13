//
//  RealmContainer.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/11/06.
//
//

import Foundation
import RealmSwift

/// A type returns and stores Realm instance that initialized with Realm.Configuration.
public protocol Container {
    var configuration: Realm.Configuration { get }
    func realm() throws -> Realm
}

public extension Container {

    func realm() throws -> Realm {
        return try Realm(configuration: configuration)
    }
}
