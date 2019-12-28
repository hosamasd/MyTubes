//
//  HomeVC.swift
//  MyTubes
//
//  Created by hosam on 12/28/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {
    
     fileprivate let cellId = "cellId"
    var homeVideoArray = [VideoModel]()
    
    lazy var menuBar:MenuBarView = {
        let me = MenuBarView()
//        me.delgate = self
//        me.isUserInteractionEnabled = true
        me.constrainHeight(constant: 50)
        return me
    }()
    
     let titlesName = [" Home"," Subscriptions"," Trending"," Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
        fetchVideos()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVideoArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        let video = homeVideoArray[indexPath.item]
        
        cell.video = video
        return cell
    }
    
    func fetchVideos()  {
        APIServices.shared.getSharedAPIFromUrl { (videos, err) in
            if let err=err{
                print(err.localizedDescription);return
            }
            guard let videos = videos else {return}
            self.homeVideoArray = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func setupNavigation() {
        let   titleLabs = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabs.text = " Home"
        titleLabs.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabs.textColor = .white
        navigationItem.titleView = titleLabs
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 230, g: 30, b: 31)
    }
    
    func setupMenu()  {
        navigationController?.hidesBarsOnSwipe = true
        view.addSubview(menuBar)
        
        menuBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
    }
    
    override func setupCollection() {
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 66, left: 16, bottom: 16, right: 16)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.width - 32
        
        return .init(width: height, height: height  )
    }
}
