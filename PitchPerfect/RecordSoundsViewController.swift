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
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    var isInitialPlay: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    override func viewWillAppear(animated: Bool) {
        setUpViewWillAppear()
        let image = UIImage(named: "record Image") as UIImage?
        recordButton.setImage(image, forState: .Normal)
    }
    
    // Delegate Method
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url,title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else {
            recordButton.enabled = true
            stopButton.hidden = false
            stopButton.enabled = true
            pauseButton.enabled = false
        }
    }
    
    // Delegate Method
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("Encode Error Occured: ", error.localizedDescription);
    }

    func setUpViewWillAppear() {
        recordingLabel.text = "Tap to record"
        recordButton.enabled = true
        stopButton.hidden = true
        pauseButton.enabled = true
        pauseButton.hidden = true
        isInitialPlay = true
    }
    
    
    func setUpRecordButton() {
        recordingLabel.text = "recording in progress"
        recordButton.enabled = false
        stopButton.hidden = false
        pauseButton.hidden = false
        pauseButton.enabled = true
        isInitialPlay = false
    }
    
    // isInitialPlay tracks whether it is first time recording or it is continue recording
    // If it is a first time recording then create a file to store audio and record it else just record
    @IBAction func recordButton(sender: UIButton) {
        if (isInitialPlay != nil)
        {
            if (isInitialPlay == true) {
                setUpRecordButton()
                let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
                let recordingName = "my_audio.wav"
                let pathArray = [dirPath, recordingName]
                let filePath = NSURL.fileURLWithPathComponents(pathArray)
                
                var session = AVAudioSession.sharedInstance()
                session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
                
                audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
                audioRecorder.delegate = self
                audioRecorder.meteringEnabled = true
                audioRecorder.prepareToRecord()
                audioRecorder.record()
            }
            else if (isInitialPlay == false) {
                setUpRecordButton()
                audioRecorder.record()
            }
        }
    }
    
    func setUpPauseButton() {
        recordingLabel.text = "Click to continue recording"
        recordButton.enabled = true
        stopButton.hidden = false
        pauseButton.enabled = false
    }
    
    @IBAction func pauseButton(sender: UIButton) {
        setUpPauseButton()
        let image = UIImage(named: "start Image") as UIImage?
        recordButton.setImage(image, forState: .Normal)
        audioRecorder.pause()
    }
    
    func setUpStopButton() {
        recordingLabel.text = "Recording Complete";
    }
    
    @IBAction func stopButton(sender: UIButton) {
        audioRecorder.stop();
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
        
    }
    
}

