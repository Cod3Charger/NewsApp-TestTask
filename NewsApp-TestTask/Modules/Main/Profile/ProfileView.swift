//
//  ProfileView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        HStack {
            Image("avatar")
            VStack(alignment: .leading) {
                Text("Dianne Russell").font(Font.interSemiBold24)
                HStack {
                    Image("badge")
                    Text("Bookworm")
                        .foregroundStyle(Color(uiColor: .profileBlue))
                }
                .padding(.top, -10)
            }
            .padding(.leading, 14)
        }
        .padding(.top, 16)

        Divider()
            .padding(.horizontal, 30)
            .padding(.top, 10)

        HStack {
            Text("Premium").font(Font.interBold24)
            Spacer()
            Button(action: {}) {
                Text(viewModel.isPurchased ? "Enabled" : "Subscribe").font(Font.interSemiBold14)
                    .foregroundStyle(.black)
                    .frame(width: 116, height: 40)
                    .background(Color(uiColor: .profileSubscribe))
                    .cornerRadius(10)
            }
            .disabled(true)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)

        Divider()
            .padding(.horizontal, 30)

        VStack {
            if viewModel.isPurchased {
                HStack {
                    Text("Bookmarks").font(Font.interBold24)
                    Spacer()
                }
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 200)
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            if viewModel.bookmarks.isEmpty {
                                Text("Bookmarks is empty").font(.merriweatherRegular16)
                                    .padding(.top, 50)
                            } else {
                                ForEach(viewModel.bookmarks, id: \.self) { article in
                                    NewsArticleView(
                                        article: article,
                                        navigateAction: { viewModel.navigateToDetails(article: article) }
                                    )
                                }
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        Spacer()
    }
}

#Preview {
    let moduleFactory = ModuleFactory()
    let coordinator = ProfileCoordinator(goToDetailsScreen: {_ in })

    return moduleFactory.makeProfileView(coordinator: coordinator)
}

