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
    var homeSubscribtionArray = [VideoModel]()
    var homeTrendingArray = [VideoModel]()
    
    lazy var menuBar:MenuBarView = {
        let me = MenuBarView()
        me.delgate = self
//        me.isUserInteractionEnabled = true
        me.constrainHeight(constant: 50)
        return me
    }()
    let activityIndicatorView: UIActivityIndicatorView = {
        let ac  = UIActivityIndicatorView(style: .whiteLarge)
        ac.color = .black
        ac.startAnimating()
        //        aiv.hidesWhenStopped = true
        return ac
    }()
    
    lazy var settingg:MoreSettingView = {
        let set = MoreSettingView()
        set.delgate = self
        
        return set
    }()
    
     let titlesName = [" Home"," Subscriptions"," Trending"," Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
        fetchVideos()
    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return homeVideoArray.count
//    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomesCell
        
        if indexPath.item == 0 {
            cell.feedCollection.videoArray = homeVideoArray
        }else if indexPath.item == 1 {
            cell.feedCollection.videoArray = homeSubscribtionArray
        }else if indexPath.item == 2 {
            cell.feedCollection.videoArray = homeTrendingArray
        }else {
        
        cell.feedCollection.videoArray = homeVideoArray
        }
        cell.feedCollection.collectionView.reloadData()
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x / 4
        menuBar.leftHorizentalBarViewConstraint.constant = x
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height - 50)
    }
    
    func scrollToSpecificIndex(indexNumber:Int)  {
        let index = IndexPath(item: indexNumber, section: 0)
        
        collectionView.scrollToItem(at: index, at: .right, animated: true)
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "     \(titlesName[indexNumber])"
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let item = targetContentOffset.pointee.x / view.frame.width
        
        let index = IndexPath(item: Int(item), section: 0)
        menuBar.collectionView.selectItem(at: index, animated: true, scrollPosition: .right)
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = titlesName[Int(item)]
        }
    }
    
    func fetchVideos()  {
        
        var group1: [VideoModel]?
        var group2: [VideoModel]?
        var group3: [VideoModel]?
        //to sync data that can be fetched
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIServices.shared.getApiData(completion: { (videos, err) in
            dispatchGroup.leave()
            group1 = videos
        })
        
        dispatchGroup.enter()
        
        APIServices.shared.getApiDataFromTrnding(completion: { (videos, err) in
            dispatchGroup.leave()
            group2 = videos
        })
        
        dispatchGroup.enter()
        APIServices.shared.getApiDataFromSubscription(completion: { (videos, err) in
            dispatchGroup.leave()
            group3 = videos
        })
        
       
        
        dispatchGroup.notify(queue: .main) {
            
            self.activityIndicatorView.stopAnimating()
            
            if let group = group3 {
                self.homeSubscribtionArray=group
            }
            if let group = group1 {
                self.homeVideoArray=group
            }
            if let group = group2 {
                self.homeTrendingArray=group
            }
            self.collectionView.reloadData()
        }
    }
    
    override func setupNavigation() {
        navigationController?.hidesBarsOnSwipe = true
        let   titleLabs = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabs.text = "      Home"
        titleLabs.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabs.textColor = .white
        navigationItem.titleView = titleLabs
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 230, g: 30, b: 31)
        
        let more = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
         let search = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItems = [more,search]
        
    }
    
    func setupMenu()  {
        navigationController?.hidesBarsOnSwipe = true
        view.addSubview(menuBar)
        
        menuBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
    }
    
    override func setupCollection() {
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView.backgroundColor = .white
//        collectionView.contentInset = .init(top: 66, left: 16, bottom: 16, right: 16)
        
       
        collectionView.register(HomesCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
    }
    
    
   @objc func handleMore()  {
        settingg.showSetting()
    }
    
    @objc func handleSearch()  {
        scrollToSpecificIndex(indexNumber: 2)
    }
}


extension HomeVC : linkedVCS {
    func showVCForSetting(setting: SettingModel, vc: UIViewController) {
        
        let newVC = vc
        newVC.view.backgroundColor = .green
        newVC.navigationItem.title = setting.name
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    
    
}

extension HomeVC: MenuBarViewProtocol {
    
    func didTapCell(index: Int) {
        scrollToSpecificIndex(indexNumber: index)
    }
    
    
    
}
