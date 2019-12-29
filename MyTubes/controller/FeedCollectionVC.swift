//
//  FeedCollectionVC.swift
//  MyTubes
//
//  Created by hosam on 12/29/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class FeedCollectionVC: BaseVC {
    
    fileprivate let cellId = "cellId"
    var videoArray = [VideoModel]()
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        let video = videoArray[indexPath.item]
        
        cell.video = video
        return cell
    }
    
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height = view.frame.width - 32
    
            return .init(width: height, height: height  )
        }
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 66, left: 16, bottom: 16, right: 16)
        collectionView.scrollIndicatorInsets = .init(top: 66, left: 16, bottom: 16, right: 16)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
}
