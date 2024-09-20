//
//  OnboardingView.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI
import FirebaseAuth

struct OnboardingView: View {

    @StateObject private var viewModel: OnboardingViewModel
    @State var isShowingBottomSheet = true
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)

    init(viewModel: OnboardingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(.all)

            VStack {
                Image("onboardingBack")
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
        }
    }
}

// MARK: ViewBuilders

private extension OnboardingView {
    @ViewBuilder
    var bottomSheet: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Get The Latest News And Updates").font(Font.interSemiBold32)
                    .padding(.horizontal, 40)
                    .padding(.top, 40)
                Text("NewsApp brings you the world’s best journalism, all in one place. Trusted sources, curated by editors, and personalized for you. ").font(Font.regularSchibstedGrotesk18)
                    .padding(.horizontal, 40)
                    .padding(.top, 8)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            if userLoggedIn {
                Button {
                    viewModel.router.navigateToNextScreen()
                } label: {
                    HStack {
                        Image("google")
                        Text("You already logged in").font(Font.poppinsSemiBold16)
                            .foregroundColor(Color(uiColor: .googleTextGray))
                    }
                    .padding()
                    .background(Color(uiColor: .googleButtonGray))
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            } else {
                Button(action: {
                    Task {
                        do {
                            try await Authentication().googleOauth()
                        } catch AuthenticationError.runtimeError(_) {

                        }
                    }
                }) {
                    HStack {
                        Image("google")
                        Text("Sign in with Google").font(Font.poppinsSemiBold16)
                            .foregroundColor(Color(uiColor: .googleTextGray))
                    }
                    .padding()
                    .background(Color(uiColor: .googleButtonGray))
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    let moduleFactory = ModuleFactory()
    let coordinator = OnboardingCoordinator()

    return moduleFactory.makeOnboardingView(coordinator: coordinator)
}
