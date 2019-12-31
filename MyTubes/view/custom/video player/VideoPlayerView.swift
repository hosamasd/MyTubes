//
//  VideoPlayerView.swift
//  MyTubes
//
//  Created by hosam on 12/29/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    
    var video :VideoModel? {
        didSet {
//            setupPalyervIEW()
        }
    }
    
    
    var isPlayed:Bool = true
    var avPlayer:AVPlayer?
    
    lazy var activyIndicators:UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
//        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.startAnimating()
        ai.stopAnimating()
        return ai
    }()
    lazy var playButton:UIButton = {
        let ai = UIButton()
        ai.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
        ai.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        ai.isHidden = true
        ai.constrainWidth(constant: 50)
        ai.constrainHeight(constant: 50)
        return ai
    }()
    let dismissButton:UIButton = {
        let ai = UIButton()
        ai.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        ai.addTarget(self, action: #selector(handleMinimize), for: .touchUpInside)
//        ai.isHidden = true
        ai.constrainWidth(constant: 50)
        ai.constrainHeight(constant: 50)
        return ai
    }()

    lazy var mainContainerView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor(white: 0, alpha: 1)
        vi.constrainHeight(constant: 250)
        vi.isUserInteractionEnabled = true
        return vi
    }()
    let videlLenghtLabel:UILabel = {
        let vi = UILabel(text: "03:00", font: .systemFont(ofSize: 14), textColor: .white, textAlignment: .right)
//        vi.constrainWidth(constant: 60)
        vi.constrainHeight(constant: 24)
//          vi.isHidden = true
        return vi
    }()
    let videoStarterLabel:UILabel = {
        let vi = UILabel(text: "00:00", font: .systemFont(ofSize: 14), textColor: .white, textAlignment: .left)
//        vi.constrainWidth(constant: 60)
        vi.constrainHeight(constant: 24)
        return vi
    }()
    lazy var sliderTimer:UISlider = {
        let sl = UISlider()
        sl.minimumTrackTintColor = .red
        sl.maximumTrackTintColor = .green
//        sl.isHidden = true
        sl.addTarget(self, action: #selector(handleVideoPlaying), for: .valueChanged)
        
        return sl
    }()
    lazy var titleLabel = UILabel(text: "fdghfdgd dfgdfgssdf", font: .systemFont(ofSize: 20), textColor: .black)
     lazy var numberOfViewsLabel = UILabel(text: "dsfgdgdf dfgdf", font: .systemFont(ofSize: 18), textColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPalyervIEW()
        
        backgroundColor = .black
        
        setupViews()
        addGradiantLayer()
    }
    
    func addGradiantLayer()  {
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.frame = bounds
        gradiantLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradiantLayer.locations = [ 0,7, 1,2]
        mainContainerView.layer.addSublayer(gradiantLayer)
    }
    
    func setupViews()  {
        addSubViews(views: mainContainerView,titleLabel,numberOfViewsLabel)
        mainContainerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        mainContainerView.addSubViews(views: activyIndicators,playButton,sliderTimer,videoStarterLabel,videlLenghtLabel,dismissButton)
        
        videoStarterLabel.anchor(top: nil, leading:mainContainerView.leadingAnchor, bottom: mainContainerView.bottomAnchor, trailing: nil,padding: .init(top: 16, left: 8, bottom: 12, right: 0))
        sliderTimer.anchor(top: nil, leading: videoStarterLabel.trailingAnchor, bottom: mainContainerView.bottomAnchor, trailing: mainContainerView.trailingAnchor,padding: .init(top: 16, left: 8, bottom: 8, right: 74))
        videlLenghtLabel.anchor(top: nil, leading:sliderTimer.trailingAnchor, bottom: mainContainerView.bottomAnchor, trailing: mainContainerView.trailingAnchor,padding: .init(top: 16, left: 8, bottom: 16, right: 12))
        dismissButton.anchor(top: mainContainerView.topAnchor, leading:mainContainerView.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 60, left: 8, bottom: 0, right: 0))
        activyIndicators.centerInSuperview()
        playButton.centerInSuperview()
        titleLabel.anchor(top: mainContainerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 8, bottom: 0, right: 0))
         numberOfViewsLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 8, bottom: 0, right: 0))
    }
    
    func setupPalyervIEW()  {
        //using local file
//        guard let path = Bundle.main.path(forResource: "most", ofType:"mp4") else {
//            debugPrint("video.m4v not found")
//            return
//        }
//        avPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726") else { return }

        avPlayer = AVPlayer(url: url)
        let videoPlayers = AVPlayerLayer(player: avPlayer)
        self.layer.addSublayer(videoPlayers)
        videoPlayers.frame = self.frame
        
        avPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        //track player progress
        
        let cmTime = CMTime(value: 1, timescale: 2)
        
        avPlayer?.addPeriodicTimeObserver(forInterval: cmTime, queue: DispatchQueue.main, using: { (progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
            let minutesString = String(format: "%02d",   Int(seconds / 60))
            
            self.videoStarterLabel.text = "\(minutesString):\(secondsString)"
            
            guard let duration = self.avPlayer?.currentItem?.duration else {return}
            let totalSec = CMTimeGetSeconds(duration)
            self.sliderTimer.value = Float(seconds / totalSec)
            
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activyIndicators.stopAnimating()
            mainContainerView.backgroundColor = UIColor.clear
            playButton.isHidden = false
            sliderTimer.isHidden = false
            guard let duration = avPlayer?.currentItem?.duration else{return}
            let seconds = CMTimeGetSeconds(duration)
            let secondText = Int(seconds.truncatingRemainder(dividingBy: 60))
            let mintueText = String(format: "%02d", Int(seconds) / 60)
            videlLenghtLabel.text = "\(mintueText):\(secondText)"
            
            videoStarterLabel.text = "00:00"
            
        }
    }
    
    
  
    
    @objc func handleVideoPlaying(sender: UISlider){
        print(99999)
        guard let duration = avPlayer?.currentItem?.duration else { return  }
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = Float64(sender.value) * totalSeconds
        
        let seekTime = CMTime(seconds: value, preferredTimescale: 1)
        
        avPlayer?.seek(to: seekTime, completionHandler: { (copleted) in
            print(321)
        })
        
    }
    
    @objc func handlePlay(sender:UIButton){
        print(789)
        if isPlayed {
            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            avPlayer?.play()
        } else {
            sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            avPlayer?.pause()
        }
        isPlayed = !isPlayed
        
    }
    
   @objc func handleMinimize()  {
        print(956)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
