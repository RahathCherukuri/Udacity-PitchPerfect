//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Rahath cherukuri on 8/30/15.
//  Copyright (c) 2015 Rahath cherukuri. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        stopAllAudio()
    }
    
    @IBAction func snailButton(sender: UIButton) {
        playAudio(0)
    }
    
    @IBAction func rabbitButton(sender: UIButton) {
        playAudio(1)
    }
    
    @IBAction func chipMunkButton(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthVaderButton(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func reverbButton(sender: UIButton) {
        reverb(50,reverbPresent: AVAudioUnitReverbPreset.LargeChamber)
    }

    @IBAction func stopButton(sender: UIButton) {
        stopAllAudio()
    }
    
    func playAudio(buttonClicked: Int){
        stopAndResetAudio()
        if (buttonClicked == 0)
        {
            audioPlayer.rate = 0.5
            
        } else if (buttonClicked == 1) {
            
            audioPlayer.rate = 2.0
        }
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        playWithPitchOrReverb(changePitchEffect)
    }
    
    func reverb(wetDryMix: Float,reverbPresent: AVAudioUnitReverbPreset) {
        var audioUnitReverb = AVAudioUnitReverb()
        audioUnitReverb.wetDryMix = wetDryMix
        audioUnitReverb.loadFactoryPreset(reverbPresent)
        playWithPitchOrReverb(audioUnitReverb)
    }

    func playWithPitchOrReverb(audioUnit: AVAudioUnit) {
        stopAndResetAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(audioUnit)
        
        audioEngine.connect(audioPlayerNode, to: audioUnit, format: nil)
        audioEngine.connect(audioUnit, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func stopAndResetAudio() {
        stopAllAudio()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
    }
    
    func stopAllAudio() {
        audioPlayer.stop()
        audioEngine.stop()
    }
}
