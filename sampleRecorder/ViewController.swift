//
//  ViewController.swift
//  sampleRecorder
//
//  Created by RIho OKubo on 2016/05/26.
//  Copyright © 2016年 RIho OKubo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //良い書き方　何度も使うものをグローバル変数にしておく
    let fileManager = NSFileManager()//写真、動画、音楽などのファイル読み書き処理
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let fileName = "sample.caf"//swiftでよく見かける音声ファイルの拡張子が.caf


    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioRecorder()
        
    }
    
   
    
    @IBAction func tapBtnRecord(sender: UIButton) {
        audioRecorder?.record()
        
    }
    @IBAction func tapBtnPlay(sender: UIButton) {
        play()
    }
    
    //録音するために必要な設定を行う
    //viewDidLoad時に行う
    func setupAudioRecorder() {
        //再生と録音機能をアクティブにする
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryRecord)
        try! session.setActive(true)
        let recordSetting : [String : AnyObject] = [
            AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey : 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        
        do {
            try audioRecorder = AVAudioRecorder(URL:
                self.documentFilePath(), settings: recordSetting)
        }catch{
            print("初期設定でerror出たよ（ー＿ー；）")
        }
        
    }
    
    //再生
    func play() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: self.documentFilePath())
        } catch{
            print("再生時にerror出たよ")
        }
        audioPlayer?.play()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //録音するファイルのパスを取得（録音時、再生時に参照）
    // swift2からstringByAppendPathComponentが使えなくなったので少し面倒
    func documentFilePath()-> NSURL {
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        
        let dirURL = urls[0]
        
        return dirURL.URLByAppendingPathComponent(fileName)
    }



}

