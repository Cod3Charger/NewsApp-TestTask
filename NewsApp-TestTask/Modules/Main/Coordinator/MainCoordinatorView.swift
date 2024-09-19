//
//  MainCoordinatorView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct MainCoordinatorView: View {

    private let moduleFactory: CoordinatorFactory
    @StateObject private var coordinator: MainCoordinator

    @State private var selectedTab = 0

    init(moduleFactory: CoordinatorFactory, coordinator: MainCoordinator) {
        self.moduleFactory = moduleFactory
        self._coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NewsCoordinatorView(moduleFactory: self.moduleFactory, coordinator: NewsCoordinator())
                    .tag(0)
                ProfileCoordinatorView(moduleFactory: self.moduleFactory, coordinator: ProfileCoordinator())
                    .tag(1)
            }

            ZStack {
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self) { item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            customTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
            }
            .frame(width: 390, height: 80)
            .background(Color(uiColor: .tabbar).opacity(0.7))
            .cornerRadius(15, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea(.all)
    }
}

// MARK: - Private Methods

private extension MainCoordinatorView {
    func customTabItem(imageName: String, isActive: Bool) -> some View{
        HStack {
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            Spacer()
        }
    }
}
