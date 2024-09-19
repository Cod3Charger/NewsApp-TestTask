//
//  View.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
