//
//  PhotosViewController.swift
//  Nexora
//
//  Created by Mac on 1/13/19.
//  Copyright © 2019 aatalyk. All rights reserved.
//

import UIKit
import RealmSwift

class PhotosViewController: UIViewController {
    
    var networkProvider: Networkable!
    var photos: [Photo] = []
    
    lazy var photosView: PhotosView = {
        let photosView = PhotosView()
        photosView.translatesAutoresizingMaskIntoConstraints = false
        photosView.collectionView.dataSource = self
        photosView.collectionView.delegate = self
        return photosView
    }()
    
    init(networkProvider: Networkable) {
        super.init(nibName: nil, bundle: nil)
        self.networkProvider = networkProvider
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(photosView)
        setupNavigationBar()
        fetchPhotos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        setupLayout()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Photos"
    }
    
    private func setupLayout() {
        photosView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photosView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        photosView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        photosView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func fetchPhotos() {
        photosView.activityIndicatorView.startAnimating()
        networkProvider.fetchPhotos { [weak self] photos in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                weakSelf.photosView.photos = photos
                weakSelf.photosView.collectionView.reloadData()
                weakSelf.photosView.activityIndicatorView.stopAnimating()
            }
        }
    }
}
