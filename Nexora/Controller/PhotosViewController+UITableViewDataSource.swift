//
//  PhotosViewController+UITableViewDataSource.swift
//  Nexora
//
//  Created by Mac on 1/13/19.
//  Copyright © 2019 aatalyk. All rights reserved.
//

import UIKit
import Kingfisher

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosView.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photosView.photos[indexPath.row]
        cell.titleLabel.text = photo.title
        if let url = URL(string: photo.thumbnailUrl) {
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: 150)
    }
}

