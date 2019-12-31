//
//  VideoPayer.swift
//  MyTubes
//
//  Created by hosam on 12/30/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import AVKit

class VideoPayer: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let activyIndicators:UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        //        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.startAnimating()
        return ai
    }()
    let playeutton:UIButton = {
        let ai = UIButton()
        ai.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
//        ai.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        ai.isHidden = true
        ai.constrainWidth(constant: 50)
        ai.constrainHeight(constant: 50)
        return ai
    }()
    lazy var mainContainerView:UIView = {
        let vi = UIView()
        vi.backgroundColor = .red//UIColor(white: 0, alpha: 1)
//        vi.constrainHeight(constant:frame.width * 9 / 16 )
        vi.constrainHeight(constant: 200)
        return vi
    }()
    let videlLenghtLabel:UILabel = {
        let vi = UILabel()
        vi.font = UIFont.boldSystemFont(ofSize: 14)
        vi.textColor = .white
        vi.textAlignment = .right
        vi.constrainWidth(constant: 60)
        vi.constrainHeight(constant: 24)
        vi.text = "sdg sdgdf dfgdfsg "
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
        vi.text = "sdg sdgdf dfgdfsg "
        //  vi.isHidden = true
        return vi
    }()
    lazy var sliderTimer:UISlider = {
        let sl = UISlider()
        sl.minimumTrackTintColor = .red
        sl.maximumTrackTintColor = .green
        sl.isHidden = true
//        sl.addTarget(self, action: #selector(handleVideoPlaying), for: .valueChanged)
        return sl
    }()
    let titleLabel = UILabel(text: "", font: .systemFont(ofSize: 20), textColor: .black)
    let numberOfViewsLabel = UILabel(text: "", font: .systemFont(ofSize: 18), textColor: .lightGray)
    
    
    func setupViews()  {
        backgroundColor = .black
        addSubview(mainContainerView)
        
        mainContainerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 150, left: 8, bottom: 0, right: 8))
        mainContainerView.addSubViews(views: activyIndicators,playeutton,videlLenghtLabel,sliderTimer,videoStarterLabel)
        
        
        videoStarterLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,padding: .init(top: 0, left: 8, bottom: 8, right: 0))
        sliderTimer.anchor(top: nil, leading: videoStarterLabel.trailingAnchor, bottom: bottomAnchor, trailing: nil,padding: .init(top: 0, left: 8, bottom: 8, right: 0))
        videlLenghtLabel.anchor(top: nil, leading: sliderTimer.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 8, bottom: 8, right: 8))
        
        playeutton.centerInSuperview()
        activyIndicators.centerInSuperview()
    }
    
  
    
}
