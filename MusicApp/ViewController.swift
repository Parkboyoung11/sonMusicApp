//
//  ViewController.swift
//  MusicApp
//
//  Created by VuHongSon on 8/1/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    var listLink : [String]!
    var listImage : [String]!
    var index : Int?
    var player : AVAudioPlayer!
    var name:String = ""

    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var prgTime: UIProgressView!
    @IBOutlet weak var sldVolume: UISlider!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgCoverImage: UIImageView!
    @IBOutlet weak var lblCurrentTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = name
        let url:NSURL = NSURL(string: "http://sonvuhong.com/list.php?cot=Link")!
        let img_url:NSURL = NSURL(string: "http://sonvuhong.com/list.php?cot=Image")!
        let queue = DispatchQueue(label: "queue")
        queue.async {
            do {
                let ds:NSString = try NSString(contentsOf: url as URL, encoding: String.Encoding.utf8.rawValue)
                self.listLink = ds.components(separatedBy: "#") as [String]
                let url:URL = URL(string: self.listLink[self.index!])!
                do{
                    let data = try Data(contentsOf: url)
                    do{
                        self.player = try AVAudioPlayer(data: data)
                        self.player.numberOfLoops = -1
                        if self.player.play() {
                            DispatchQueue.main.async {
                                self.lblLoading.isHidden = true
                                self.btnPause.isHidden = false
                                self.prgTime.isHidden = false
                                self.player.volume = 1
                                self.sldVolume.isHidden = false
                                self.updateSong()
                            }
                        }
                    }catch {}
                }catch {}
            }catch {
                print("Load Error")
            }
        }
        
        let queue_img = DispatchQueue(label: "queue_img")
        queue_img.async {
            do {
                let ds:NSString = try NSString(contentsOf: img_url as URL, encoding: String.Encoding.utf8.rawValue)
                self.listImage = ds.components(separatedBy: "#") as [String]
                let url:URL = URL(string: self.listImage[self.index!])!
                do{
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imgCoverImage.image = UIImage(data: data)
                        self.lblName.isHidden = false
                    }
                }catch {
                    DispatchQueue.main.async {
                        self.imgCoverImage.image = #imageLiteral(resourceName: "boyoung")
                        self.lblName.isHidden = false
                    }
                }
            }catch {
                print("Load Error")
            }
        }
    }
    
    @IBAction func btnPlayDid(_ sender: UIButton) {
        player.play()
        updateSong()
        self.btnPause.isHidden = false
        self.btnPlay.isHidden = true
    }

    @IBAction func sldVolumeDid(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    @IBAction func btnPauseDid(_ sender: UIButton) {
        player.pause()
        self.btnPause.isHidden = true
        self.btnPlay.isHidden = false
    }
    @IBAction func btnBackDid(_ sender: UIButton) {
        if player != nil {
            player.stop()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func updateSong() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (time) in
            UIView.animate(withDuration: 0.5, animations: { 
                self.prgTime.setProgress(Float(self.player.currentTime / self.player.duration), animated: true)
                let duration = self.convertSecToMin(secs: Int(self.player.duration))
                let current = self.convertSecToMin(secs: Int(self.player.currentTime))
                self.lblCurrentTime.text = current + "/" + duration
            })
        }
    }
    
    func convertSecToMin(secs: Int) -> String {
        let min = Int(secs / 60)
        let sec = Int(secs % 60)
        let minStr : String = String(format: "%02d:%02d", min, sec)
        return minStr
    }
}

