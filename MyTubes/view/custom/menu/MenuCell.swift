//
//  MenuCell.swift
//  MyTubes
//
//  Created by hosam on 12/28/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {

    var image:UIImage! {
        didSet{
            menuImage.image = image.withRenderingMode(.alwaysTemplate)
            tintColor  = UIColor.init(r: 91, g: 14, b: 13)
        }
    }
    
    lazy var menuImage:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate))
        im.isUserInteractionEnabled = true
        im.translatesAutoresizingMaskIntoConstraints = false
        return im
     }()
    
    
    override func setupViews()  {
        addSubview(menuImage)
        
        addSubview(menuImage)
    
        menuImage.centerInSuperview()
    }
    
    override var isHighlighted: Bool {
        didSet{
           menuImage.tintColor = isHighlighted ? .darkGray : UIColor.init(r: 91, g: 14, b: 13)
        }
    }
    
    override var isSelected: Bool{
        didSet{
           menuImage.tintColor = isSelected ? .white : UIColor.init(r: 91, g: 14, b: 13)
        }
    }
}
