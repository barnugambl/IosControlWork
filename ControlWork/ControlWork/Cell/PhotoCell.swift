//
//  PhotoCell.swift
//  ControlWork
//
//  Created by Терёхин Иван on 22.11.2024.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    private lazy var photo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.backgroundColor = .red
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with images: [UIImage]) {
        for image in images {
            photo.image = image
        }
    }
    
    private func setupLayout() {
        contentView.addSubview(photo)
        contentView.addSubview(indicator)
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: photo.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: photo.centerYAnchor),
        ])
    }
}

extension PhotoCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

