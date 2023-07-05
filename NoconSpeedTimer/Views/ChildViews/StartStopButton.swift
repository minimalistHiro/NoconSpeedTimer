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
        if viewModel.mode == .start {
            Button {
                viewModel.mode = .stop
                viewModel.applyButtons()
            } label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize, height: buttonSize)
                    .foregroundColor(able)
            }
        } else if viewModel.mode == .stop {
            Button {
                viewModel.mode = .start
                viewModel.applyButtons()
            } label: {
                Image(systemName: "pause.fill")
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
            }
        }
    }
}
