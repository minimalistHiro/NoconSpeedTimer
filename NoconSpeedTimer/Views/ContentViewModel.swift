//
//  ContentViewModel.swift
//  NoconSpeedTimer
//
//  Created by 金子広樹 on 2023/07/05.
//

import SwiftUI
import AVFoundation

final class ContentViewModel: ObservableObject {
    static var shared: ContentViewModel = ContentViewModel()
    
    @Published var mode: TimerMode = .zero
    var timer = Timer()                                                     // タイマー
    @Published var tappedKeyboardTime: Double = 0.0         // キーボード入力から次のキーボード入力までの時間
    @Published var isTimerStart: Bool = false               // true:タイマースタート, false:タイマーストップ
    var backgroundTaskId = UIBackgroundTaskIdentifier.init(rawValue: 0)     // バックグラウンド用トークン
    let alert: AlertSounds = AlertSounds()                                  // アラート
    
    // 時間関係
    @Published var elapsedTime: Double = 0.0                                // 時間計測用変数
    var minutes: Int { return Int(elapsedTime / 60) }                       // 分
    var second: Int { return Int(elapsedTime) % 60 }                        // 秒
    // 各種時間表示テキストを1桁ずつ分ける
    var minutesTensPlace: String {
        let number = String(format: "%02d", minutes)
        return String(number.dropLast())
    }                                                                       // 分の10の位
    var minutesOnesPlace: String {
        let number = String(format: "%02d", minutes)
        return String(number.dropFirst())
    }                                                                       // 分の1の位
    var secondTensPlace: String {
        let number = String(format: "%02d", second)
        return String(number.dropLast())
    }                                                                       // 秒の10の位
    var secondOnesPlace: String {
        let number = String(format: "%02d", second)
        return String(number.dropFirst())
    }                                                                       // 秒の10の位
    
    enum TimerMode {
        case zero
        case start
        case stop
    }
    
    ///　ボタン入力から実行処理を分配する。
    /// - Parameters: なし
    /// - Returns: なし
    func applyButtons() {
        switch mode {
        case .zero:
            reset()
        case .start:
            startTime()
        case .stop:
            stopTime()
        }
    }
    
    ///　キーボード入力から実行処理を分配する。
    /// - Parameters:
    ///   - keyboard: 入力されたキーボード
    /// - Returns: なし
    func applyKeyboard(_ keyboard: Int) {
        var displayText = String(minutesTensPlace) + String(minutesOnesPlace)
        displayText.removeFirst()
        displayText += String(keyboard)
        elapsedTime = Double(displayText)! * 60
        
        // 入力後の時間計測用変数が0の場合、何もせず返す。
        if elapsedTime == 0 {
            return
        }
        //　2桁数字を打たれた時のために、一度初期化する。
        tappedKeyboardTime = 0
        isTimerStart = false
        timer.invalidate()
        // キーボード入力から1秒後に自動的にタイマーをスタートする。
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [self] _ in
            tappedKeyboardTime += 1.0
            // 2秒後、タイマーをスタートさせる。
            if tappedKeyboardTime >= 1 {
                isTimerStart = true
            }
        }
    }
    
    ///　タイマーを開始
    /// - Parameters: なし
    /// - Returns: なし
    func startTime() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] _ in
            // タイマーをメインスレッドと別スレッドで実行。
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
            // バックグラウンド処理開始
            backgroundTaskId = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
            
            // 時間計測用変数が0になったら場合、タイマーをリセットする。
            if (elapsedTime - 1) < 0 {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                alert.playSound()
                mode = .zero
                applyButtons()
                return
            }
// MARK: - テスト用
//            elapsedTime -= 1.0
            elapsedTime -= 0.1
        }
    }
    
    ///　タイマーを停止
    /// - Parameters: なし
    /// - Returns: なし
    func stopTime() {
        timer.invalidate()
        // バックグラウンド処理終了
        UIApplication.shared.endBackgroundTask(backgroundTaskId)
    }
    
    ///　タイマーをリセット
    /// - Parameters: なし
    /// - Returns: なし
    func reset() {
        timer.invalidate()
        // バックグラウンド処理終了
        UIApplication.shared.endBackgroundTask(backgroundTaskId)
        elapsedTime = 0
    }
}
