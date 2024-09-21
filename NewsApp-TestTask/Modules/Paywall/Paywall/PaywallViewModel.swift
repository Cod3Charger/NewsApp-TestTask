//
//  PaywallViewModel.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation
import StoreKit

final class PaywallViewModel: ObservableObject {

    @Published var product: Product?
    @Published var isPurchased: Bool = false

    let storeKitManager: StoreKitManager
    let router: Router

    init(storeKitManager: StoreKitManager, router: Router) {
        self.storeKitManager = storeKitManager
        self.router = router

        Task {
            await loadSubscribeProduct()
        }
    }
}


// MARK: - Methods

extension PaywallViewModel {

    func loadSubscribeProduct() async {
        if let product = storeKitManager.storeProducts.first(where: { $0.id == "com.newsapp" }) {
            self.product = product
            isPurchased = await isSubscribePurchased()
        }
    }

    func isSubscribePurchased() async -> Bool {
        guard let product = product else { return false }
        do {
            return try await storeKitManager.isPurchased(product)
        } catch {
            print("Failed to check purchase status: \(error)")
            return false
        }
    }

    func navigateToNextScreen() {
        router.navigateToNextScreen()
    }
}

// MARK: - Router

extension PaywallViewModel {
    struct Router {
        let navigateToNextScreen: () -> Void
    }
}
