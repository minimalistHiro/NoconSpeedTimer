//
//  StartStopButton.swift
//  NoconSpeedTimer
//
//  Created by 金子広樹 on 2023/07/05.
//

import SwiftUI

struct StartStopButton: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    
    var body: some View {
        switch viewModel.mode {
        case .start:
            Button {
                viewModel.mode = .stop
                viewModel.applyButtons()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Image(systemName: "pause.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize, height: buttonSize)
                    .foregroundColor(able)
            }
        case .stop:
            Button {
                viewModel.mode = .start
                viewModel.applyButtons()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize, height: buttonSize)
                    .foregroundColor(able)
            }
        case .zero:
            Button {
                viewModel.mode = .start
                viewModel.applyButtons()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize, height: buttonSize)
                    .foregroundColor(able)
            }
        }
    }
}
