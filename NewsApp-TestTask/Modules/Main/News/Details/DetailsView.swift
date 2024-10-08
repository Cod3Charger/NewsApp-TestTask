//
//  DetailsView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 20.09.2024.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject private var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Image("paywallBack")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                    .ignoresSafeArea(.all)
                Spacer()
            }

            VStack {
                Spacer()
                bottomSheet
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                customTabBar
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

// MARK: - View Builders

extension DetailsView {

    @ViewBuilder
    var bottomSheet: some View {
        VStack(alignment: .leading) {
            Text(viewModel.article.title).font(Font.interSemiBold32)
                .padding(.horizontal, 20)
            HStack {
                Text(viewModel.article.author ?? "Unknown Author").font(Font.interRegular12)
                    .foregroundColor(.secondary)

                Circle()
                    .fill(Color.secondary)
                    .frame(width: 2, height: 2)

                Text(formatDate(viewModel.article.publishedAt)).font(Font.interRegular12)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal, 20)

            Text(viewModel.article.description ?? "There is no description").font(Font.merriweatherRegular16)
                .padding(.horizontal, 20)
                .padding(.top, 20)
        }
        .offset(y: -20)
    }

    @ViewBuilder
    var customTabBar: some View {
        HStack {
            Button(action: {
                viewModel.navigateToNewsScreen()
            }) {
                Image("long-arrow-left")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .frame(width: 20, height: 20)
            }
            .padding(.leading, 50)
            .contentShape(Rectangle())

            Spacer()

            if viewModel.isPurchased {
                HStack {
                    Button(action: {
                        viewModel.uploadArticle()
                    }) {
                        Image(systemName: viewModel.isAddedToBookmarks ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    }
                    .contentShape(Rectangle())
                    .padding(.trailing, 30)
                }

                Button(action: {
                    viewModel.openOriginalArticle()
                }) {
                    Image("share")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .frame(width: 20, height: 20)
                }
                .padding(.trailing, 50)
                .contentShape(Rectangle())
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 80)
        .background(Color(uiColor: .tabBarDetails).opacity(0.6))
        .cornerRadius(15, corners: [.topLeft, .topRight])
        .padding(.horizontal)
    }
}

// MARK: - Private Methods

private extension DetailsView {
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            outputFormatter.timeStyle = .none
            return outputFormatter.string(from: date)
        }
        return dateString
    }
}


#Preview {
    let article =
    NewsArticle(
        source: Source(id: "1", name: "Test Source"),
        author: "John Doe",
        title: "Very Very Large First Test Article With Twelve Words And Two Symbols!!",
        description: "Forests are one of the most important natural resources that our planet possesses. Not only do they provide us with a diverse range of products such as timber, medicine, and food, but they also play a vital role in mitigating climate change and maintaining the overall health of our planet's ecosystems. In this article, we will explore the ways in which forests are helping our world.",
        url: "https://example.com/1",
        urlToImage: "https://24ai.tech/en/wp-content/uploads/sites/3/2023/10/01_product_1_sdelat-izobrazhenie-4-3-3-scaled.jpg",
        publishedAt: "2024-09-20T12:00:00Z"
    )

    let moduleFactory = ModuleFactory()
    let coordinator = DetailsCoordinator(article: article, goToNewsScreen: {})

    return moduleFactory.makeDetailsView(coordinator: coordinator, article: article)
}
