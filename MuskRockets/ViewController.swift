//
//  ViewController.swift
//  MuskRockets
//
//  Created by John Gallaugher on 11/12/17.
//  Copyright © 2017 John Gallaugher. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var blastOffButton: UIButton!
    
    let numberOfRockets = 5
    var currentRocket = 0
    var yAtLanding: CGFloat = 0
    var rocketPlayer = AVAudioPlayer()
    var offScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        yAtLanding = self.rocketImage.frame.origin.y
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: Data from \(soundName) could not be played")
            }
        } else {
            print("Error reading in sound")
        }
        
    }

    @IBAction func blastOffPressed(_ sender: UIButton) {
        playSound(soundName: "rocketsound", audioPlayer: &rocketPlayer)
        // if offScreen == false {
        if yAtLanding == self.rocketImage.frame.origin.y {
            UIView.animate(withDuration: 2, animations: {
                self.rocketImage.frame.origin.y = -(self.rocketImage.frame.height)}) { _ in
                self.rocketPlayer.stop()}
            self.blastOffButton.setTitle("Return", for: .normal)
            offScreen = true
        } else {
            UIView.animate(withDuration: 2, animations: {self.rocketImage.frame.origin.y = self.yAtLanding
            }) { _ in
                self.rocketPlayer.stop()}
            self.blastOffButton.setTitle("Blast Off!", for: .normal)
            offScreen = false
        }
    }
    
    @IBAction func rocketTapped(_ sender: UITapGestureRecognizer) {
        
        currentRocket += 1
        if currentRocket == numberOfRockets {
            currentRocket = 0
        }
        rocketImage.image = UIImage(named: "rocket\(currentRocket)")
        
    }
    
}

