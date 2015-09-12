//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Rahath cherukuri on 8/26/15.
//  Copyright (c) 2015 Rahath cherukuri. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var isInitialPlay: Bool!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    override func viewWillAppear(animated: Bool) {
        println("In viewWillAppear");
        recordingLabel.text = "Tap to record";
        recordButton.enabled = true;
        stopButton.hidden = true;
        pauseButton.enabled = true;
        pauseButton.hidden = true;
        isInitialPlay = true;
        let image = UIImage(named: "record Image") as UIImage?
        recordButton.setImage(image, forState: .Normal);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag) {
                println("audioRecorderDidFinishRecording");
            recordedAudio = RecordedAudio(filePathUrl: recorder.url,title: recorder.url.lastPathComponent!);
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio);
        }
        else {
            println("audioRecorderDidFinishRecording");
            //println("Recording button is not successful");
            recordButton.enabled = true;
            stopButton.hidden = true;
        }
    }

    
    
    @IBAction func recordButton(sender: UIButton) {
        if (isInitialPlay != nil && isInitialPlay == true) {
            println("In recordButton");
            recordingLabel.text = "recording in progress";
            recordButton.enabled = false;
            stopButton.hidden = false;
            pauseButton.hidden = false;
            pauseButton.enabled = true;
            isInitialPlay = false;
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            let recordingName = "my_audio.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = NSURL.fileURLWithPathComponents(pathArray)
            //println(filePath)
            
            var session = AVAudioSession.sharedInstance()
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
            audioRecorder.delegate = self;
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }
        else if(isInitialPlay != nil && isInitialPlay == false) {
            audioRecorder.record();
            recordingLabel.text = "recording in progress";
            recordButton.enabled = false;
            stopButton.hidden = false;
            pauseButton.enabled = true;
            pauseButton.hidden = false;

        }
        
    }
    
    
    @IBAction func pauseButton(sender: UIButton) {
        println("In pauseButton");
        recordButton.enabled = true;
//        pauseButton.hidden = true;
        stopButton.hidden = false;
        pauseButton.enabled = false;
//        stopButton.enabled = false;
        
        recordingLabel.text = "Click to continue recording";
        let image = UIImage(named: "start Image") as UIImage?
        recordButton.setImage(image, forState: .Normal);
        audioRecorder.pause();
    }
    
    @IBAction func stopButton(sender: UIButton) {
        println("In stopButton");
        audioRecorder.stop();
        recordingLabel.text = "Recording Complete";
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data;
        }
        
    }
    
}

