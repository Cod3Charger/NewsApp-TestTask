//
//  NewsArticleView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 20.09.2024.
//

import SwiftUI

struct NewsArticleView: View {
    let article: NewsArticle
    let navigateAction: () -> Void

    var body: some View {
        Button {
            navigateAction()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(article.title).font(Font.interSemiBold18)
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    HStack {
                        Text(article.author ?? "Unknown Author").font(Font.interRegular12)
                            .foregroundColor(.secondary)

                        Circle()
                            .fill(Color.secondary)
                            .frame(width: 2, height: 2)

                        Text(formatDate(article.publishedAt)).font(Font.interRegular12)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.leading, 16)

                Spacer()

                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 60)
                        .cornerRadius(15)
                } placeholder: {
                    Image("defaultImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 60)
                        .cornerRadius(15)
                }
                .padding(.trailing, 10)
            }
        }
    }
}

// MARK: - Private Methods

private extension NewsArticleView {
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
            description: "This is the description for the first test article.",
            url: "https://example.com/1",
            urlToImage: "https://24ai.tech/en/wp-content/uploads/sites/3/2023/10/01_product_1_sdelat-izobrazhenie-4-3-3-scaled.jpg",
            publishedAt: "2024-09-20T12:00:00Z"
        )

    return NewsArticleView(article: article, navigateAction: {})
}
