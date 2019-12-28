//
//  MoreSettingView.swift
//  MyTubes
//
//  Created by hosam on 12/28/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit


protocol linkedVCS {
    func showVCForSetting(setting:SettingModel,vc:UIViewController)
}

class MoreSettingView: UIView {
    
    fileprivate  let height:CGFloat  = 300
    fileprivate let cellID = "cellID"
    lazy var blackView:UIView = {
        let v = UIView(backgroundColor: UIColor(white: 0, alpha: 0.5))
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        v.alpha = 0
        return v
    }()
    var settingArray = [SettingModel]()
    var delgate:linkedVCS?
    
    
    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        cv.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
        return cv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSettings(){
        settingArray.removeAll()
        let newSet1 = SettingModel(name: "Settings", imageName: "settings")
        let newSet2 = SettingModel(name: "Terms & privacy policy", imageName: "privacy")
        let newSet3 = SettingModel(name: "Send feedback", imageName: "feedback")
        let newSet4 = SettingModel(name: "Help", imageName: "help")
        let newSet5 = SettingModel(name: "Switch account", imageName: "switch_account")
        let newSet6 = SettingModel(name: "Cancel", imageName: "cancel")
        
        
        settingArray.append(newSet1)
        settingArray.append(newSet2)
        settingArray.append(newSet3)
        settingArray.append(newSet4)
        settingArray.append(newSet5)
        settingArray.append(newSet6)
        
        
        collectionView.reloadData()
        
    }
    
    func showSetting(){
        if let window = UIApplication.shared.keyWindow {
            
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height , width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y , width: self.collectionView.frame.width, height: self.height)
            }, completion: nil)
            
        }
    }
    
    
    @objc func handleDismiss(){
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height , width: window.frame.width, height: window.frame.height)
            }
        })
    }
}

extension MoreSettingView: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return settingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        let setting = settingArray[indexPath.section]
        
        cell.settings = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            delgate?.showVCForSetting(setting: settingArray[indexPath.section], vc: FeedbackVC())
            handleDismiss()
        case 1:
            delgate?.showVCForSetting(setting: settingArray[indexPath.section], vc: FeedbackVC())
            handleDismiss()
        case 2:
            delgate?.showVCForSetting(setting: settingArray[indexPath.section], vc: FeedbackVC())
            handleDismiss()
        case 3:
            delgate?.showVCForSetting(setting: settingArray[indexPath.section], vc: FeedbackVC())
            handleDismiss()
        case 4:
            delgate?.showVCForSetting(setting: settingArray[indexPath.section], vc: FeedbackVC())
            handleDismiss()
        case 5:
            handleDismiss()
        default:
            ()
    }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
