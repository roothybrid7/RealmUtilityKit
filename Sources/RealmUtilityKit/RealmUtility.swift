//
//  RealmUtility.swift
//  RealmUtilityKit
//
//  Created by SATOSHI OHKI on 1/13/17.
//
//

import Foundation
import RealmSwift

/// A type is that object persist to realm store.
///
/// Similar to the NSCoding protocol I/F.
public protocol RealmCodable {
    func encode(with realm: Realm) throws
}

public protocol RealmPopulatable {
    func populate(with realm: Realm) throws
}

public protocol RealmUpdatable {
    associatedtype Entity: RealmSwift.Object
    func update(withRealmObject object: Entity)
}
