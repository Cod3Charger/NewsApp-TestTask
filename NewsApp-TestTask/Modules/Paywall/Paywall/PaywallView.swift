//
//  PaywallView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

struct PaywallView: View {

    @StateObject private var viewModel: PaywallViewModel

    init(viewModel: PaywallViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            VStack {
                Image("paywallBack")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea(.all)
                Spacer()
            }

            VStack {
                Spacer()
                bottomSheet
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .ignoresSafeArea(edges: .bottom)

            VStack {
                HStack {
                    closeButton
                    .padding(.leading, 20)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

// MARK: ViewBuilders

private extension PaywallView {

    @ViewBuilder
    var closeButton: some View {
        Button(action: {
            viewModel.router.navigateToNextScreen()
        }) {
            Image("closeButton")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
        }
    }

    @ViewBuilder
    var bottomSheet: some View {
        VStack {
            Text("NewsApp Premium").font(Font.interSemiBold32)
                .padding(.horizontal, 40)
                .padding(.top, 50)
            Text("NewsApp brings you the world’s best journalism, all in one place. Trusted sources, curated by editors, and personalized for you. ").font(Font.regularSchibstedGrotesk18)
                .padding(.horizontal, 40)
                .padding(.top, 8)
                .foregroundStyle(.secondary)
            Spacer()

            Text("$4.49 per month").font(Font.helveticaBold16)
            Button(action: {
                viewModel.router.navigateToNextScreen()
            }) {
                Text("Subscribe").font(Font.libreFranklinBold22)
                    .frame(width: 360, height: 60)
                    .foregroundStyle(.white)
                    .background(Color(UIColor.paywallRed))
                    .cornerRadius(20)
            }
            .padding(.bottom, 10)

            HStack(spacing: 15) {
                Text("Restore Purchases").font(Font.libreFranklinBold12)
                Text("Terms of Use").font(Font.libreFranklinBold12)
                Text("Privacy Policy").font(Font.libreFranklinBold12)
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    let moduleFactory = ModuleFactory()
    let coordinator = PaywallCoordinator()

    return moduleFactory.makePaywallView(coordinator: coordinator)
}

