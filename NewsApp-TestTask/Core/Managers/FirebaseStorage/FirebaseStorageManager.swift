//
//  FirebaseStorageManager.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 22.09.2024.
//

import Foundation
import FirebaseStorage

final class FirebaseStorageManager {

    func uploadArticleToStorage(article: NewsArticle, completion: @escaping (Result<URL, Error>) -> Void) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let jsonData = try encoder.encode(article)

            let storageRef = Storage.storage().reference().child("articles/\(article.title).json")

            storageRef.putData(jsonData, metadata: nil) { metadata, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                storageRef.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    func downloadArticleFromStorage(articleTitle: String, completion: @escaping (Result<NewsArticle, Error>) -> Void) {
        let storageRef = Storage.storage().reference().child("articles/\(articleTitle).json")
        
        storageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "FirebaseStorage", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found."])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let article = try decoder.decode(NewsArticle.self, from: data)
                completion(.success(article))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
