//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Mohamed Moghazi on 6/5/15.
//  Copyright (c) 2015 Mohamed Elmoghazi. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePath: NSURL!
    var title: String!
    
    init(filePathURL: NSURL, title: String){
        
        self.filePath = filePathURL
        self.title = title
    }
    
}