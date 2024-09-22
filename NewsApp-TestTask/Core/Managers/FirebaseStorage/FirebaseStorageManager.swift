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

    func downloadAllArticles(completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        let storageRef = Storage.storage().reference().child("articles")

        storageRef.listAll { (result, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let items = result?.items else {
                completion(.success([]))
                return
            }

            var articles: [NewsArticle] = []
            let group = DispatchGroup()

            for item in items {
                group.enter()
                item.getData(maxSize: 10 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("Failed to load article \(item.name): \(error)")
                        group.leave()
                        return
                    }

                    guard let data = data else {
                        group.leave()
                        return
                    }

                    do {
                        let decoder = JSONDecoder()
                        let article = try decoder.decode(NewsArticle.self, from: data)
                        articles.append(article)
                    } catch {
                        print("Failed to decode article \(item.name): \(error)")
                    }
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                completion(.success(articles))
            }
        }
    }

    func articleExists(articleTitle: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let storageRef = Storage.storage().reference().child("articles/\(articleTitle).json")

        storageRef.getMetadata { metadata, error in
            if let error = error {
                if let storageError = error as? NSError, storageError.code == StorageErrorCode.objectNotFound.rawValue {
                    completion(.success(false))
                } else {
                    completion(.failure(error))
                }
            } else {
                completion(.success(true))
            }
        }
    }
}
