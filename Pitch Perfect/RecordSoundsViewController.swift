//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mohamed Moghazi on 6/2/15.
//  Copyright (c) 2015 Mohamed Elmoghazi. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var microphoneIcon: UIButton!
    
    var audioRecord: AVAudioRecorder!
    
    var recordedAudio: RecordedAudio!

    @IBOutlet weak var recordingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        microphoneIcon.enabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Recording Button
    @IBAction func recordButton(sender: AnyObject) {
        
        //showing "Recording" label, showing Stop Button and Disabling the Record Button
        recordingLabel.text = "..Recording.."
        stopButton.hidden = false
        microphoneIcon.enabled = false
        
        // creating constant of the dir path where audio will be saved
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) [0] as! String
        
        //hardcoding the recording name, each audio record will overwrite the old one
        let recordingName = "Audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray as [AnyObject])

        // creating variable of a recording session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecord = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecord.delegate = self
        audioRecord.meteringEnabled = true
        audioRecord.prepareToRecord()
        audioRecord.record()

    }
    
    //the code will be excuted only when recording finished
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            
            //creating an object of RecordedAudio Class
            recordedAudio = RecordedAudio(filePathURL: recorder.url, title: recorder.url.lastPathComponent!)
            
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {

            recordingLabel.hidden = true
            stopButton.hidden = true
            microphoneIcon.enabled = true
        }
        
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundVC.recievedAudio = data
            
        }
    }
    
    /// *Stop Recording* Button
    @IBAction func stopRecording(sender: AnyObject) {
        recordingLabel.text = "Tap to Record"
        stopButton.hidden = true
        microphoneIcon.enabled = true
        audioRecord.stop()
    
    //Ending Recording Session
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

