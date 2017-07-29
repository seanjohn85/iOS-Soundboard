//
//  RecordScreenViewController.swift
//  Soundboard
//
//  Created by JOHN KENNY on 29/07/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit
import AVFoundation

class RecordScreenViewController: UIViewController {
    //audio modles
    var audioRec : AVAudioRecorder?
    
    var audioPlayer : AVAudioPlayer?
    
    var audioURL : URL?
    
    //ui elements
    @IBOutlet var name: UITextField!
    
    @IBOutlet var recordbutLabel: UIButton!
    
    @IBOutlet var playbtn: UIButton!
    
    @IBOutlet var addbtn: UIButton!
    
    
    func setUpRec(){
        
     
        do{
            //create audio session
            let session = AVAudioSession.sharedInstance()
            //session to play and record
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            //create audio settings
            
            var settings :[String: AnyObject] = [:]
            settings [AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject
            settings [AVSampleRateKey] = 44100.0 as AnyObject
            settings [AVNumberOfChannelsKey] = 2 as AnyObject
            
            //create url for file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print(audioURL!)
            //create audio recorder object
            audioRec = try AVAudioRecorder(url: audioURL!, settings: settings)
            //start audio recorder
            audioRec?.prepareToRecord()
        }catch let error as NSError{
            print(error)
            
        }
       
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRec()
        playbtn.isEnabled = false
    }
    
    
    @IBAction func play(_ sender: Any) {
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        }catch{}
        
    }

    
    @IBAction func rec(_ sender: Any) {
        if audioRec!.isRecording{
            //stop the sercording
            audioRec?.stop()
            //change button title
            recordbutLabel.setTitle("Record", for: .normal)
            //enable play btn
            playbtn.isEnabled = true
            
        }else{
            //start reording
            audioRec?.record()
            //change button title to stop
            recordbutLabel.setTitle("Stop", for: .normal)
            
        }
    }
    

    @IBAction func add(_ sender: Any) {
    }
}
