//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Rahath cherukuri on 9/6/15.
//  Copyright (c) 2015 Rahath cherukuri. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!

    init(filePathUrl: NSURL, title: String)
    {
        self.filePathUrl = filePathUrl;
        self.title = title;
    }
    
    override var description: String {
        return "filePathUrl: \(filePathUrl)" + "\n" + 
        "title: \(title)"
    }
}

