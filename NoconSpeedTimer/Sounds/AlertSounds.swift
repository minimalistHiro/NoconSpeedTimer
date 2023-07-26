//
//  AlertSounds.swift
//  NoconSpeedTimer
//
//  Created by 金子広樹 on 2023/07/05.
//

import SwiftUI
import AVFoundation

class AlertSounds: NSObject {
    let data = NSDataAsset(name: "AlertSounds")!.data
    var player: AVAudioPlayer!
    let audioSession = AVAudioSession.sharedInstance()
    
    func playSound() {
        do {
            player = try AVAudioPlayer(data: data)
            // マナーモードでも音を鳴らすようにする
            try audioSession.setCategory(.playback)
            
            player.stop()
            player.currentTime = 0.0
            player.play()
        } catch {
            print("音の再生に失敗しました。")
        }
    }
}
