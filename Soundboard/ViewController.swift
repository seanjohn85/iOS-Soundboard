//
//  ViewController.swift
//  Soundboard
//
//  Created by JOHN KENNY on 29/07/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var audioPlayer : AVAudioPlayer?
    
    //sound objects arry
    var sounds : [Sound] = []
    @IBOutlet var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
    }

    //play sound on selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let s = sounds[indexPath.row]
        //set up adsio player
        do{
            audioPlayer = try AVAudioPlayer(data: s.audio as! Data)
            audioPlayer!.play()
        }catch{}
        //remove hightsight from the sell
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
    //no of rows based on no of sounds in core data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let s = sounds[indexPath.row]
        print("s name is")
        print(s.name)
        cell.textLabel?.text = s.name
        
        return cell
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //get context from appdelegate
        let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            sounds = try ctx.fetch(Sound.fetchRequest())
            tableview.reloadData()
            print(sounds.count)
        }catch{}
        
    }
}

