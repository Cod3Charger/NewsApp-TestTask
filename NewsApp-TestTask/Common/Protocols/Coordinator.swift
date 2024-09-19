//
//  Coordinator.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

protocol Coordinator: ObservableObject where Screen: Routable {
    associatedtype Screen
    var navigationPath: [Screen] { get }
}
