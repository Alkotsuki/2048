//
//  Top100.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Score {
    var name: String
    var score: Int
    
    static func uploadToFirestore(_ score: Score) {
        
        let db  = Firestore.firestore()
        db.collection("scores").addDocument(data: [
            "name" : score.name,
            "score": score.score
        ]) { (error) in
            if let error = error {
                print("Failed to upload data: \(error)")
            }
        }
        
    }
    
    
    static func loadTop100FromFirestore(completion: @escaping ([Score]) -> Void) {
        var scores: [ Score ] = []
        let db = Firestore.firestore()
//        let ref = db.collection("scores")
        
        db.collection("scores").order(by: "score", descending: true).limit(to: 100).getDocuments { (query, error) in
            
            if let error = error {
                print("Error downloading data: \(error)")
            } else {
                
                for document in query!.documents {
                    if let name = document.get("name") as? String,
                        let score = document.get("score") as? Int {
                        let newScore = Score(name: name, score: score)
                        scores.append(newScore)
                    }
                }
                completion(scores)
            
            }
        }
        
    }


    
    static func loadSampleTop100() -> [Score] {
        let sampleScore1  = Score(name: "Silvia", score: 2892)
        let sampleScore2  = Score(name: "Chloe", score: 1220)
        let sampleScore3  = Score(name: "Jessy", score: 2128)
        let sampleScore4  = Score(name: "Stella", score: 2096)
        let sampleScore5  = Score(name: "Jack", score: 838)
        let sampleScore6  = Score(name: "Samantha", score: 614)
        let sampleScore7  = Score(name: "Veronika", score: 1620)
        let sampleScore8  = Score(name: "Shawna", score: 1878)
        let sampleScore9  = Score(name: "Asa", score: 1200)
        let sampleScore10 = Score(name: "Madison", score: 2028)
        
        return [sampleScore1, sampleScore2, sampleScore3,
                sampleScore4, sampleScore5, sampleScore6,
                sampleScore7, sampleScore8, sampleScore9,
                sampleScore10].sorted(by: {$0.score > $1.score})
    }
    
    
}
