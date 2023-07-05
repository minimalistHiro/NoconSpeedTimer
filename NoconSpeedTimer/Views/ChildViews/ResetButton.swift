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
        if viewModel.mode == .start {
            // 空白のボタン
            Button { } label: {
                Image(systemName: "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize, height: buttonSize)
                    .foregroundColor(able)
            }
        } else if viewModel.mode == .stop {
            Button {
                viewModel.mode = .zero
                viewModel.applyButtons()
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
            }
        }
    }
}
