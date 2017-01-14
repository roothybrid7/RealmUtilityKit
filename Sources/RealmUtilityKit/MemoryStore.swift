//
//  MemoryStore.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/12/03.
//
//

import Foundation
import RealmSwift

public struct MemoryStore: Container {

    public fileprivate(set) var configuration: Realm.Configuration

    public init(memoryIdentifier: String) throws {
        let configuration = Realm.Configuration(inMemoryIdentifier: memoryIdentifier)
        self.configuration = configuration
        try prepare(configuration: configuration)
    }

    fileprivate func prepare(configuration conf: Realm.Configuration) throws {
        let _ = try Realm(configuration: conf)
    }
}
