//
//  ProfileViewModel.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {

    @Published var isPurchased: Bool = false

    let storeKitManager: StoreKitManager
    let router: Router

    init(storeKitManager: StoreKitManager, router: Router) {
        self.storeKitManager = storeKitManager
        self.router = router

        Task {
            await checkSubscribe()
        }
    }
}

// MARK: - Methods

extension ProfileViewModel {
    
    func checkSubscribe() async {
        if let product = storeKitManager.storeProducts.first(where: { $0.id == "com.newsapp" }) {
            do {
                isPurchased = try await storeKitManager.isPurchased(product)
            } catch {
                print("Failed to check purchase status: \(error)")
            }
        }
    }
}

// MARK: - Router

extension ProfileViewModel {
    struct Router {
        let navigateToNextScreen: () -> Void
    }
}

