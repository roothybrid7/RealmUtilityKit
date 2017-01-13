//
//  RealmFileStore.swift
//  RealmUtilityKit
//
//  Created by Satoshi Ohki on 2016/11/06.
//
//

import Foundation
import RealmSwift

/// This realm has File data storage.
public struct RealmFileStore: RealmContainer {

    public fileprivate(set) var configuration: Realm.Configuration

    public init(fileURL: URL, encryptionKey: Data? = nil, defaultConfiguration: Realm.Configuration? = nil) throws {
        var configuration = defaultConfiguration ?? Realm.Configuration()
        configuration.fileURL = fileURL.standardizedFileURL
        configuration.encryptionKey = encryptionKey
        self.configuration = configuration

        try prepare(configuration: configuration)
    }

    fileprivate func prepare(configuration conf: Realm.Configuration) throws {
        if let fileURL = conf.fileURL {
            try createDirectoryIfNeeded(fileURL.deletingLastPathComponent())
        }
        let _ = try Realm(configuration: conf)
    }

    fileprivate func createDirectoryIfNeeded(_ dirURL: URL) throws {
        try FileManager.default.createDirectory(at: dirURL, withIntermediateDirectories: true, attributes: nil)
    }
}
