//
//  NewsServiceError.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 20.09.2024.
//

import Foundation

enum NewsServiceError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}
