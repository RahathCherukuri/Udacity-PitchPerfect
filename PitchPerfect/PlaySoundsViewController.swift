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
        
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
//        {
//            let fileUrl = NSURL.fileURLWithPath(filePath);
//            
//            
//        } else {
//            println("There is no file at that location.");
//        }
        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil);
        audioPlayer.enableRate = true;
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func snailButton(sender: UIButton){
        playAudio(0);
    }
    
    @IBAction func rabbitButton(sender: UIButton) {
        playAudio(1);
    }
    
    
    @IBAction func chipMunkButton(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func darthVaderButton(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop();
    }
    
    func playAudio(buttonClicked: Int){
        audioPlayer.stop();
        audioPlayer.currentTime = 0.0;
        
        if(buttonClicked == 0)
        {
            audioPlayer.rate = 0.5;
            
        } else if(buttonClicked == 1) {
            
            audioPlayer.rate = 2.0;
        }
        audioPlayer.play();
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
