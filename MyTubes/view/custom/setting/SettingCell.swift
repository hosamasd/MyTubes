//
//  SettingCell.swift
//  MyTubes
//
//  Created by hosam on 12/28/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
class SettingCell: BaseCell {
    
    var settings:SettingModel! {
        didSet {
            settingTitle.text = settings.name
            settingImage.image = UIImage(named: settings.imageName)
        }
    }
    
    let settingImage:UIImageView = {
        let im = UIImageView()
        im.constrainWidth(constant: 34)
        im.constrainHeight(constant: 34)
        im.layer.cornerRadius = 16
        im.clipsToBounds = true
        return im
    }()
    let settingTitle:UILabel = {
        let la = UILabel()
        return la
    }()
    
    
    
    
    override var isSelected: Bool{
        didSet{
            backgroundColor = isSelected ? .darkGray : .white
            settingTitle.textColor = isSelected ? .white : UIColor.black
            settingImage.tintColor = isSelected ? .darkGray : .white
        }
    }
    
    override func setupViews() {
        
        backgroundColor = .white
        
        
        hstack(settingImage,settingTitle, spacing: 16, alignment: .center).withMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
    }
}
