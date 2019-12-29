//
//  VideoLauncher.swift
//  MyTubes
//
//  Created by hosam on 12/29/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit
import AVFoundation

class  VideoLauncher: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        showVideoPlayer()
    }
    
    func showVideoPlayer(video:VideoModel)  {
        
        if let window = UIApplication.shared.keyWindow {
            let views = UIView(frame: window.frame)
            views.backgroundColor = .white
            
            views.frame = CGRect(x: window.frame.width - 10, y: window.frame.height - 10, width: 50, height: 50)
            let height = window.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: window.frame.width, height: height)
            let videoPayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            views.addSubview(videoPayerView)
            window.addSubview(views)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                views.frame = window.frame
            }, completion: { (_) in
                UIApplication.shared.isStatusBarHidden = true
                
            })
            
            
        }
    }
    
}
