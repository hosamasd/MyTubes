//
//  VideoModel.swift
//  MyTubes
//
//  Created by hosam on 12/28/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

struct VideoModel:Codable {
    let title: String
    let numberOfViews: Int
    let thumbnailImageName: String
    let channel: Channel
    let duration: Int
    
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case numberOfViews = "number_of_views"
        case thumbnailImageName = "thumbnail_image_name"
        case channel, duration
    }
    
}

