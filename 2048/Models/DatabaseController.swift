//
//  DatabaseController.swift
//  2048
//
//  Created by Pavel Koval on 8/30/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DatabaseController {
    
    static let shared = DatabaseController()
    
    private init() {}
    
    //Uploading scores to Firestore
    func uploadToFirestore(_ score: Score) {
        
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
    
    //Getting scores from Firestore
    func downloadTop100FromFirestore(completion: @escaping ([Score]) -> Void) {
        
        var scores: [ Score ] = []
        let db = Firestore.firestore()
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
  
    
}
