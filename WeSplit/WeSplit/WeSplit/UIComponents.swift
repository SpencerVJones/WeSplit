//  UIComponents.swift
//  WeSplit
//  Created by Spencer Jones on 6/14/25.

import Foundation
import SwiftUI

@ViewBuilder
func cardView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    content()
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
}

@ViewBuilder
func resultCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    content()
        .padding()
        .background(
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: .blue.opacity(0.3), radius: 12, x: 0, y: 8)
}

func circularButton(systemName: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Image(systemName: systemName)
            .font(.title2.bold())
            .foregroundColor(.blue)
            .frame(width: 44, height: 44)
            .background(Circle().fill(.blue.opacity(0.1)))
            .overlay(Circle().stroke(.blue, lineWidth: 2))
    }
    .buttonStyle(.plain)
}

func breakdownItem(title: String, amount: Double) -> some View {
    VStack(spacing: 4) {
        Text(title)
            .font(.caption)
            .foregroundColor(.white.opacity(0.8))
        
        Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .font(.subheadline.bold())
            .foregroundColor(.white)
    }
    .frame(maxWidth: .infinity)
}
