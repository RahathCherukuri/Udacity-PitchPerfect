//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Rahath cherukuri on 8/26/15.
//  Copyright (c) 2015 Rahath cherukuri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var recordingOutlet: UILabel!

    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true;
        recordButton.enabled = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordButton(sender: UIButton) {
        recordingOutlet.hidden = false;
        stopButton.hidden = false;
        recordButton.enabled = false;
        
    }
    
    @IBAction func stopButton(sender: UIButton) {
        recordingOutlet.hidden = true;
    }
    
}

