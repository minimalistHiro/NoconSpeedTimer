//
//  ContentView.swift
//  NoconSpeedTimer
//
//  Created by 金子広樹 on 2023/07/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 5) {
                Text(viewModel.minutesTensPlace)
                    .frame(width: timerLabelFrameWidth, alignment: .trailing)
                Text(viewModel.minutesOnesPlace)
                    .frame(width: timerLabelFrameWidth, alignment: .trailing)
                Text(":")
                Text(viewModel.secondTensPlace)
                    .frame(width: timerLabelFrameWidth, alignment: .trailing)
                Text(viewModel.secondOnesPlace)
                    .frame(width: timerLabelFrameWidth, alignment: .trailing)
            }
            .font(.system(size: 80))
            
            Spacer()
            
            HStack(spacing: 10) {
                Spacer()
                ResetButton()
                Spacer()
                StartStopButton()
                Spacer()
            }
            
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(1..<10) { num in
                    Button {
                        // タイマーをスタートしていない場合のみ、キーボード入力を有効にする。
                        if viewModel.mode == .zero {
                            viewModel.applyKeyboard(num)
                        }
                    } label: {
                        Text("\(num)")
                            .font(.system(size: keyboardTextSize))
                            .frame(width: keyboardFrameSize, height: keyboardFrameSize)
                            .foregroundColor(able)
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
            
            Button {
                if viewModel.mode == .zero {
                    viewModel.applyKeyboard(0)
                }
            } label: {
                Text("0")
                    .font(.system(size: keyboardTextSize))
                    .frame(width: keyboardFrameSize, height: keyboardFrameSize)
                    .foregroundColor(able)
            }
            .padding()
            
            Spacer()
        }
        .onChange(of: viewModel.isTimerStart) { value in
            // キーボード入力後、タイマーを自動的にスタートする。
            if value {
                viewModel.mode = .start
                viewModel.applyButtons()
            }
        }
        .onChange(of: viewModel.mode) { mode in
            // 画面の自動ロックの有無を状態によって振り分ける。
            switch mode {
            case .zero:
                UIApplication.shared.isIdleTimerDisabled = false
            case .start:
                UIApplication.shared.isIdleTimerDisabled = true
            case .stop:
                UIApplication.shared.isIdleTimerDisabled = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
