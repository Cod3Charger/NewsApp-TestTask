//
//  CoordinatorFactoryProtocols.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import Foundation

protocol CoordinatorFactory: LaunchViewFactory, OnboardingViewFactory, PaywallViewFactory, NewsViewFactory, ProfileViewFactory, DetailsViewFactory {}
