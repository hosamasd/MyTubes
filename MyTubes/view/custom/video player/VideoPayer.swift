//
//  VideoPayer.swift
//  MyTubes
//
//  Created by hosam on 12/30/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class VideoPayer: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()  {
        backgroundColor = .brown
    }
}
