//
//  PhotosViewController.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 2/23/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class PhotosViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    fileprivate var photoData =  PhotosViewModel()
    fileprivate var cellId = "Cell"
    fileprivate var photoMode = -1 //used to chose between albums and photos in an album
    //lazy instantation of UICollectionView
    lazy var collectionView: UICollectionView = {
        var frame:CGRect = self.view.bounds
        if let navHeight = self.navigationController?.navigationBar.frame.size.height {
            frame.origin.y += navHeight
            frame.size.height -= navHeight
        }
        let layout:UICollectionViewFlowLayout = self.setupLayout(numberOfItems: 3)
        var collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    //MARK: Activity indicator View
    private lazy var loadingView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private lazy var loadingLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = 100
        label.textColor = UIColor.gray
        label.textAlignment = NSTextAlignment.center
        label.text = "Loading..."
        return label
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView()
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        return spinner
    }()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        self.title = "Photos"
        self.setActivityIndicatorView()
        //Load data from network
        photoData.getAllPhotosFromAPIResponse{
            self.photoData.organizePhotos()
            self.collectionView.reloadData()
            self.removeActivityIndicatorView()
        }
    }
    
   //redraw collection view when screen rotates
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame  = self.view.frame
        let layout = self.setupLayout(numberOfItems: 3)
        layout.invalidateLayout()
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        self.collectionView.reloadData()
    }
    
    //set layout for collection view
    func setupLayout(numberOfItems: Int) -> UICollectionViewFlowLayout{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let totalSpace = layout.sectionInset.left
            + layout.sectionInset.right
            + (layout.minimumInteritemSpacing * CGFloat(numberOfItems - 1))
        let size = Int((self.view.bounds.width - totalSpace) / CGFloat(numberOfItems))
        layout.itemSize = CGSize(width: size, height: size)
        return layout
    
    }
    
    //MARK: Activity indicator loading
    private func setActivityIndicatorView() {
        self.spinner.startAnimating()
        //add subviews
        loadingView.addSubview(self.spinner)
        loadingView.addSubview(self.loadingLabel)
        self.collectionView.addSubview(loadingView)
        
        var navigationHeight: CGFloat = 0.0
        if let height = (self.navigationController?.navigationBar.frame.height){
            navigationHeight = height
        }
        //add constraints to activity indicator view
        loadingView.snp.makeConstraints { (make) in
            make.centerX.equalTo(collectionView.snp.centerX)
            make.centerY.equalTo(collectionView.snp.centerY).offset(-navigationHeight)
            make.width.equalTo(240)
            make.height.equalTo(100)
        }
        spinner.snp.makeConstraints { (make) in
            make.centerX.equalTo(collectionView.snp.centerX)
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(loadingLabel).offset(30)
        }
        loadingLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(collectionView.snp.centerX)
            make.bottom.equalTo(0)
        }
    }
    
    private func removeActivityIndicatorView() {
        self.spinner.stopAnimating()
        self.loadingLabel.isHidden = true
    }
}

//MARK: CollectionView datasource and delegate
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: CollectionView Datasource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (photoMode == -1){
            return photoData.getNumberOfAlbums()
        } else {
            return photoData.getNumberOfPhotos(index: self.photoMode)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionViewCell
        if(photoMode == -1){
            let albumAtIndex = photoData.getAlbumAtIndex(index: indexPath.row)
            cell.thumbnailUrl = albumAtIndex.1
            cell.title = "Album  \(albumAtIndex.0)"
        } else {
            if let albumAtIndex = photoData.getPhontoOnAlbumAtIndex(albumId: photoMode, photoID: indexPath.row) {
                cell.thumbnailUrl = albumAtIndex.thumbnailUrl
                cell.title = albumAtIndex.title
            }
        }
        return cell
    }
    
    //MARK: CollectionView Delegate Method
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if(photoMode == -1){
            self.photoMode = indexPath.row + 1
            self.collectionView.reloadData()
        } else {
            self.photoMode = -1
            self.collectionView.reloadData()
        }
    }
}
