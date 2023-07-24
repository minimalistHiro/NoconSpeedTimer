//
//  ResetButton.swift
//  NoconSpeedTimer
//
//  Created by 金子広樹 on 2023/07/05.
//

import SwiftUI

struct ResetButton: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    
    var body: some View {
        switch viewModel.mode {
        case .start:
            // 空白のボタン
            Button { } label: {
                Image(systemName: "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize, height: buttonSize)
                    .foregroundColor(able)
                    .disabled(true)
            }
        case .stop:
            Button {
                viewModel.mode = .zero
                viewModel.applyButtons()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Image(systemName: "stop.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize, height: buttonSize)
                    .foregroundColor(able)
            }
        case .zero:
            if viewModel.elapsedTime != 0 {
                Button {
                    viewModel.mode = .zero
                    viewModel.applyButtons()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                } label: {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: buttonSize, height: buttonSize)
                        .foregroundColor(able)
                }
            } else {
                // 空白のボタン
                Button { } label: {
                    Image(systemName: "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: buttonSize, height: buttonSize)
                        .foregroundColor(able)
                        .disabled(true)
                }
            }
        }
    }
}
