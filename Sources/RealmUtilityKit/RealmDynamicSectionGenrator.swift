//
//  RealmDynamicSectionGenrator.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/12/24.
//
//

import Foundation
import RealmSwift

public protocol RealmDynamicSectionGeneratorable {
    var keyPath: String { get }
    var sortDescriptor: NSSortDescriptor? { get }
    var nameConverter: ((Any) -> String) { get }
}

public struct RealmDynamicSectionGenerator: RealmDynamicSectionGeneratorable {
    public let keyPath: String
    public let sortDescriptor: NSSortDescriptor?
    public let nameConverter: ((Any) -> String)

    public init(keyPath: String, sortDescriptor: NSSortDescriptor? = nil, nameConverter: @escaping ((Any) -> String)) {
        self.keyPath = keyPath
        self.sortDescriptor = sortDescriptor
        self.nameConverter = nameConverter
    }
}
