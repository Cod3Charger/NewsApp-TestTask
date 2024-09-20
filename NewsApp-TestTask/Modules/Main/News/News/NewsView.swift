//
//  NewsView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct NewsView: View {

    @StateObject private var viewModel: NewsViewModel

    init(viewModel: NewsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Rectangle()
                    .fill(Color(uiColor: .newsBlue))
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
                        ForEach(NewsCategory.allCases, id: \.self) { segment in
                            Button(action: {
                                viewModel.selectedSegment = segment
                            }) {
                                Text(segment.rawValue.capitalized)
                                    .font(Font.interSemiBold14)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 23)
                                    .background(viewModel.selectedSegment == segment ? Color(uiColor: .newsBlue) : .white)
                                    .foregroundStyle(.black)
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(uiColor: .newsBlue), lineWidth: 2)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)

                    if viewModel.isLoading {
                        ProgressView("News loading...")
                            .padding(.top, 120)
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                if viewModel.articles.isEmpty {
                                    if let errorMessage = viewModel.errorMessage {
                                        Text("Ошибка: \(errorMessage)")
                                            .foregroundColor(.red)
                                    }
                                } else {
                                    ForEach(viewModel.articles, id: \.self) { article in
                                        NewsArticleView(
                                            article: article,
                                            navigateAction: { viewModel.navigateToDetails(article: article) }
                                        )
                                    }
                                }
                            }
                            .padding(.top, 20)
                        }
                    }
                },
                alignment: .top
            )
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            Task {
                await viewModel.loadNews(for: viewModel.selectedSegment)
                viewModel.loadTestArticles()
            }
        }
    }
}

#Preview {
    let moduleFactory = ModuleFactory()
    let coordinator = NewsCoordinator()

    return moduleFactory.makeNewsView(coordinator: coordinator)
}


