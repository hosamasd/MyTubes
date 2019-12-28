//
//  MenuBarVC.swift
//  MyTubes
//
//  Created by hosam on 12/28/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

protocol MenuBarViewProtocol {
    func didTapCell(index:Int)
}

class MenuBarView: UIView    {
    
    var delgate:MenuBarViewProtocol? 
    
    let cellID = "cellID"
    let menuImageArray = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "trending"),#imageLiteral(resourceName: "subscriptions"),#imageLiteral(resourceName: "account")]
    let horizentalBarView:UIView = {
       let v = UIView(backgroundColor: UIColor(white: 0.9, alpha: 1))
        v.constrainHeight(constant: 3)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    var leftHorizentalBarViewConstraint:NSLayoutConstraint!
    
    
    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.init(r: 230, g: 32, b: 31)
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        
//        let selectedPath = IndexPath(item: 0, section: 0)
//        collectionView.selectItem(at: selectedPath, animated: true, scrollPosition: .right)
        setupHorizentalBar()
    }
    
    
    func setupHorizentalBar()  {
        addSubview(horizentalBarView)
        
        
      leftHorizentalBarViewConstraint =   horizentalBarView.leadingAnchor.constraint(equalTo: leadingAnchor)
        leftHorizentalBarViewConstraint.isActive = true
        horizentalBarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        horizentalBarView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 1/4).isActive = true
    }
    
    func setupViews()  {
        addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        
        let index = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: index, animated: false, scrollPosition: .bottom)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBarView: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        let image = menuImageArray[indexPath.row]
        
        cell.image =  image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 4
        leftHorizentalBarViewConstraint.constant = x
        delgate?.didTapCell(index: indexPath.item)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 4
        
        return .init(width: width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
