//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mohamed Moghazi on 6/3/15.
//  Copyright (c) 2015 Mohamed Elmoghazi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    var recievedAudio:RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    
    var audioFile: AVAudioFile!
    
    /// **play at specific rate** func, used in *playslow* and *playfast*
    func playAtRate(rate: Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    ///to *stop* player and *reset engine*
    func stopAll() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
    }
    
    func playAudioWithVariablePitch (pitch: Float) {

        stopAll()
        
        //creating a player node and attaching to engine
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        //creating pitch effect and attaching it to the engine
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        //connecting both node and pitch effect and output
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        //playing the audio node
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Audio Effects"
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePath, error: nil )
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        //creating AVAudioFile from the recievedAudio file
        audioFile = AVAudioFile(forReading: recievedAudio.filePath, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //play slow effect
    @IBAction func slowPlay(sender: AnyObject) {
        stopAll()
        playAtRate(0.5)
    }
    
    //play fast effect
    @IBAction func fastPlay(sender: AnyObject) {
        stopAll()
        playAtRate(1.5)
    }
    
    //play chipmunk effect
    @IBAction func chipmunk(sender: AnyObject) {
        playAudioWithVariablePitch(1200)

    }
    
    //play darth effect
    @IBAction func darthvader(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    //stop audio button
    @IBAction func stopAudioPlayer(sender: AnyObject) {
        stopAll()
    }


}
