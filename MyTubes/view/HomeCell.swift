//
//  HomeCell.swift
//  MyTubes
//
//  Created by hosam on 12/28/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import SDWebImage
class HomeCell: BaseCell {
    
    var video:VideoModel! {
        didSet{
            let urlString = video.thumbnailImageName
            guard let url = URL(string: urlString) else { return  }
            homeImageView.sd_setImage(with: url)
            
            let urlString2 = video.channel.profileImageName
            guard let url2 = URL(string: urlString2) else { return  }
            smallImageView.sd_setImage(with: url2)
//            titleLabel.text = video.channel.name
//            discriptionLabel.text = video.title
            titleLabel.text = video.title
            discriptionLabel.text = video.channel.name
            
        }
    }
    
    let homeImageView:UIImageView = {
       let i = UIImageView(image: #imageLiteral(resourceName: "taylor_swift_blank_space"))
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    let smallImageView:UIImageView = {
        let i = UIImageView(image: #imageLiteral(resourceName: "taylor_swift_profile"))
        i.constrainHeight(constant: 40)
        i.constrainWidth(constant: 40)
        i.layer.cornerRadius = 20
        i.clipsToBounds = true
        return i
    }()
    let titleLabel = UILabel(text: "", font: .systemFont(ofSize: 20), textColor: .black,textAlignment: .left,numberOfLines: 2)
    let discriptionLabel = UILabel(text: "", font: .systemFont(ofSize: 14), textColor: .lightGray,textAlignment: .left,numberOfLines: 2)
    let seperatorView:UIView = {
       let s = UIView(backgroundColor: .lightGray)
        s.constrainHeight(constant: 0.5)
        return s
    }()
    
    
    override func setupViews() {
        backgroundColor = .white
        
       addSubview(seperatorView)
        let labels = stack(titleLabel,discriptionLabel)
        let bottom = hstack(smallImageView,labels,spacing: 16,alignment:.center).padTop(-8)
//        bottom.constrainHeight(constant: 80)
        stack(homeImageView,bottom)
        homeImageView.heightAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.8).isActive = true
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
