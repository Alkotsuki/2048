//
//  Top100.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import Foundation

struct Score: Codable {
    var name: String
    var score: Int
    
    static let defaults = UserDefaults.standard
    
    static let DocumentsDirectory = FileManager.default.urls(for: .userDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Scores").appendingPathExtension("plist")
    
    static func saveLocally(_ scores: [Score]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedScores = try? propertyListEncoder.encode(scores)
        try? codedScores?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadFromWeb() -> [Score] {
        return []
    }
    
    static func loadSample() -> [Score] {
        return []
    }
    
    
}
