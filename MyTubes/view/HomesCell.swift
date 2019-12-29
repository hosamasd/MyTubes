//
//  FeedCell.swift
//  MyTubes
//
//  Created by hosam on 12/29/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class HomesCell: BaseCell {
    
    let feedCollection = FeedCollectionVC()
    
    
    override func setupViews() {
        backgroundColor = .white
        
        stack(feedCollection.view)
    }
}
