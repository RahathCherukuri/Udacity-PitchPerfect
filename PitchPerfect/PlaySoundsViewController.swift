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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        {
            let fileUrl = NSURL.fileURLWithPath(filePath);
            audioPlayer = AVAudioPlayer(contentsOfURL: fileUrl, error: nil);
            audioPlayer.enableRate = true;
            
        } else {
            println("There is no file at that location.");
        }
        // Do any additional setup after loading the view.
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
