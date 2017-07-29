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
        addbtn.isEnabled = false
    }
    
    
    @IBAction func play(_ sender: Any) {
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        }catch{}
        
    }


    //record button functionality
    @IBAction func rec(_ sender: Any) {
        if audioRec!.isRecording{
            //stop the sercording
            audioRec?.stop()
            //change button title
            recordbutLabel.setTitle("Record", for: .normal)
            //enable play btn
            playbtn.isEnabled = true
            addbtn.isEnabled = true
            
        }else{
            //start reording
            audioRec?.record()
            //change button title to stop
            recordbutLabel.setTitle("Stop", for: .normal)
            
        }
    }
    
    //add a sound
    @IBAction func add(_ sender: Any) {
        //get context from appdelegate
        let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //sound object in core data
        let sound = Sound(context: ctx)
        //names the object using the text lable
        sound.name = name.text!
        //puts the stored audio from the url to audio url to binary in the core data sound object
        sound.audio = NSData(contentsOf: audioURL!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //moves to previous view
        navigationController?.popViewController(animated: true)
        
    }
}
