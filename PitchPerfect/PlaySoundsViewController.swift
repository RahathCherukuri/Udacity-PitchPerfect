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
    var audioPlayer1: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil);
        audioPlayer1 = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil);
        audioPlayer.enableRate = true;
        audioPlayer1.enableRate = true;
        audioEngine = AVAudioEngine();
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func snailButton(sender: UIButton){
            // playAudio(0);
        audioPlayer.stop()
        audioPlayer.currentTime = 0;
        audioPlayer.play()
        
        
        let delay:NSTimeInterval = 0.1//100ms
        var playtime:NSTimeInterval!
        playtime = audioPlayer1.deviceCurrentTime + delay
        audioPlayer1.stop()
        audioPlayer1.currentTime = 0
        audioPlayer1.volume = 0.8;
        audioPlayer1.playAtTime(playtime)

    }
    
    @IBAction func rabbitButton(sender: UIButton) {
        // playAudio(1);
        // For Reverb:
        audioPlayer.stop();
        audioPlayer1.stop();
        audioEngine.stop();
        audioEngine.reset();
        var reverb = AVAudioUnitReverb();
        reverb.wetDryMix = 50;
        reverb.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral);
        var audioPlayerNode = AVAudioPlayerNode();
        audioEngine.attachNode(audioPlayerNode);
        audioEngine.attachNode(reverb);
        audioEngine.connect(audioPlayerNode, to: reverb, format: nil);
        audioEngine.connect(reverb , to: audioEngine.outputNode, format: nil);
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil);
        audioEngine.startAndReturnError(nil);
        audioPlayerNode.play();
    }
    
    @IBAction func chipMunkButton(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthVaderButton(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop();
        audioPlayer1.stop();
        audioEngine.stop();
    }
    
    func playAudio(buttonClicked: Int){
        audioPlayer.stop();
        audioEngine.stop();
        audioEngine.reset();
        audioPlayer.currentTime = 0.0;
        
        if(buttonClicked == 0)
        {
            audioPlayer.rate = 0.5;
            
        } else if(buttonClicked == 1) {
            
            audioPlayer.rate = 2.0;
        }
        audioPlayer.play();
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop();
        audioPlayer1.stop();
        audioEngine.stop();
        audioEngine.reset();
        
        var audioPlayerNode = AVAudioPlayerNode();
        audioEngine.attachNode(audioPlayerNode);
        
        var changePitchEffect = AVAudioUnitTimePitch();
        changePitchEffect.pitch = pitch;
        audioEngine.attachNode(changePitchEffect);
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil);
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil);
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil);
        audioEngine.startAndReturnError(nil);
        
        audioPlayerNode.play();
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
