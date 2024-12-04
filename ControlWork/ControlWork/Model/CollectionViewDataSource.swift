//
//  CollectionViewDataSource.swift
//  ControlWork
//
//  Created by Терёхин Иван on 22.11.2024.
//

import UIKit

class CollectionViewDataSource: NSObject ,UICollectionViewDataSource {
    
    private var dataSource = DataManager.obtaindPhotos()
    
    
    func updateImages(_ newImages: [UIImage]) {
        self.dataSource = newImages
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        cell.configure(with: dataSource)
        return cell
    }
    

}
