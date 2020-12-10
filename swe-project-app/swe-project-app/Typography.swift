//
//  Typography.swift
//  String
//
//  Created by Justin Schwartz on 10/31/20.
//

import SwiftUI

// MARK: -
struct Body15RegularModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .regular))
            .foregroundColor(Color.white)
    }
}
extension Text {
    func Body15Regular() -> some View {
        self
            .tracking(-0.24)
            .modifier(Body15RegularModifier())
    }
}

// MARK: -
struct Body17SemiboldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(Color.white)
    }
}
extension Text {
    func Body17Semibold() -> some View {
        self
            .tracking(-0.41)
            .lineSpacing(22 - UIFont.systemFont(ofSize: 17).lineHeight)
            .padding(.vertical, (22 - UIFont.systemFont(ofSize: 17).lineHeight) / 2)
            .modifier(Body17SemiboldModifier())
    }
}

// MARK: -
struct Caption13RegularModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13, weight: .regular))
            .foregroundColor(Color.white)
    }
}
extension Text {
    func Caption13Regular() -> some View {
        self
            .tracking(-0.08)
            .lineSpacing(18 - UIFont.systemFont(ofSize: 13).lineHeight)
            .padding(.vertical, (18 - UIFont.systemFont(ofSize: 13).lineHeight) / 2)
            .modifier(Caption13RegularModifier())
    }
}
