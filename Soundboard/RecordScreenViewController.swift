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
    
    var audioRec : AVAudioRecorder?
    
    @IBOutlet var name: UITextField!
    
    @IBOutlet var recordbutLabel: UIButton!
    
    
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
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            //create audio recorder object
            audioRec = try AVAudioRecorder(url: audioURL, settings: settings)
            //start audio recorder
            audioRec?.prepareToRecord()
        }catch let error as NSError{
            print(error)
            
        }
       
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRec()
    }
    
    
    @IBAction func play(_ sender: Any) {
    }

    
    @IBAction func rec(_ sender: Any) {
    }
    

    @IBAction func add(_ sender: Any) {
    }
}
