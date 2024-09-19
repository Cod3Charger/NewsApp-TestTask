//
//  UIColor.swift
//  NewsApp-TestTask
//
//  Created by Сергей Дашко on 19.09.2024.
//

import SwiftUI

extension UIColor {

    public convenience init(hex: String, alpha: CGFloat = 1.0) {
        let r, g, b: CGFloat
        let start = hex.hasPrefix("#") ? hex.index(hex.startIndex, offsetBy: 1) : hex.startIndex
        let hexColor = String(hex[start...])

        if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000FF) / 255

                self.init(red: r, green: g, blue: b, alpha: alpha)
                return
            }
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 0)
    }
}
