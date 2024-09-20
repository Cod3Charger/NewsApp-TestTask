//
//  NewsView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct NewsView: View {

    @StateObject private var viewModel: NewsViewModel
    @State private var selectedSegment = "Travel"

    let segments = ["Travel", "Technology", "Business"]

    init(viewModel: NewsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Rectangle()
                    .fill(Color(uiColor: .newsNavBar))
                    .frame(width: UIScreen.main.bounds.width, height: 130)

                Spacer()
            }
            .overlay(
                VStack {
                    Text("NewsApp")
                        .font(Font.interSemiBold32)
                        .foregroundStyle(.primary)
                        .padding(.top, 75)

                    HStack(spacing: 10) {
                        ForEach(segments, id: \.self) { segment in
                            Button(action: {
                                selectedSegment = segment
                            }) {
                                Text(segment).font(Font.interSemiBold14)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 23)
                                    .background(selectedSegment == segment ? Color(uiColor: .newsNavBar) : .white)
                                    .foregroundStyle(.black)
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(uiColor: .newsNavBar), lineWidth: 2)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                },
                alignment: .top
            )
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    let moduleFactory = ModuleFactory()
    let coordinator = NewsCoordinator()

    return moduleFactory.makeNewsView(coordinator: coordinator)
}


