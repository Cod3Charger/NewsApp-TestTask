//
//  TabbedItems.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

enum TabbedItems: Int, CaseIterable {
    case news = 0
    case profile

    var iconName: String {
        switch self {
        case .news:
            return "news"
        case .profile:
            return "profile"
        }
    }
}
