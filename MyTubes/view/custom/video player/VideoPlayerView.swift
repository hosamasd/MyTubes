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
    
    var isPlayed:Bool = true
    var avPlayer:AVPlayer?
    
    let activyIndicators:UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
//        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.startAnimating()
        return ai
    }()
    let playeutton:UIButton = {
        let ai = UIButton()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        ai.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        ai.isHidden = true
        ai.constrainWidth(constant: 50)
        ai.constrainHeight(constant: 50)
        return ai
    }()
    let mainContainerView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor(white: 0, alpha: 1)
        
        return vi
    }()
    let videlLenghtLabel:UILabel = {
        let vi = UILabel()
        vi.font = UIFont.boldSystemFont(ofSize: 14)
        vi.textColor = .white
        vi.textAlignment = .right
        vi.constrainWidth(constant: 60)
        vi.constrainHeight(constant: 24)
        //  vi.isHidden = true
        return vi
    }()
    let videoStarterLabel:UILabel = {
        let vi = UILabel()
        vi.font = UIFont.boldSystemFont(ofSize: 14)
        vi.constrainWidth(constant: 60)
        vi.constrainHeight(constant: 24)
        vi.textColor = .white
        vi.textAlignment = .left
        //  vi.isHidden = true
        return vi
    }()
    lazy var sliderTimer:UISlider = {
        let sl = UISlider()
        sl.minimumTrackTintColor = .red
        sl.maximumTrackTintColor = .green
        sl.isHidden = true
        sl.addTarget(self, action: #selector(handleVideoPlaying), for: .valueChanged)
        return sl
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPalyervIEW()
        
        backgroundColor = .black
        
        addViews()
        addGradiantLayer()
    }
    
    func addGradiantLayer()  {
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.frame = bounds
        gradiantLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradiantLayer.locations = [ 0,7, 1,2]
        mainContainerView.layer.addSublayer(gradiantLayer)
    }
    
    func addViews()  {
        addSubview(mainContainerView)
        
        mainContainerView.addSubViews(views: activyIndicators,playeutton,videlLenghtLabel,sliderTimer,videoStarterLabel)
        stack(mainContainerView)
        
        videoStarterLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,padding: .init(top: 0, left: 8, bottom: 8, right: 0))
        sliderTimer.anchor(top: nil, leading: videoStarterLabel.trailingAnchor, bottom: bottomAnchor, trailing: nil,padding: .init(top: 0, left: 8, bottom: 8, right: 0))
         videlLenghtLabel.anchor(top: nil, leading: sliderTimer.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 8, bottom: 8, right: 8))
        
        playeutton.centerInSuperview()
        activyIndicators.centerInSuperview()
//        playeutton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        playeutton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        playeutton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        playeutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        activyIndicators.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        activyIndicators.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        mainContainerView.frame = frame
    }
    
    func setupPalyervIEW()  {
        //using local file
        guard let path = Bundle.main.path(forResource: "most", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        avPlayer = AVPlayer(url: URL(fileURLWithPath: path))
//        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726") else { return }
//
//        avPlayer = AVPlayer(url: url)
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
            playeutton.isHidden = false
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
        guard let duration = avPlayer?.currentItem?.duration else { return  }
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = Float64(sender.value) * totalSeconds
        
        let seekTime = CMTime(seconds: value, preferredTimescale: 1)
        
        avPlayer?.seek(to: seekTime, completionHandler: { (copleted) in
            print(321)
        })
        
    }
    
    @objc func handlePlay(sender:UIButton){
        if isPlayed {
            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            avPlayer?.play()
        } else {
            sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            avPlayer?.pause()
        }
        isPlayed = !isPlayed
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
