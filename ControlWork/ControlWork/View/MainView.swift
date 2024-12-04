//
//  MainView.swift
//  ControlWork
//
//  Created by Терёхин Иван on 22.11.2024.
//

import UIKit

class MainView: UIView {
    
    private let topConstant: CGFloat = 20
    private let leadingConstant: CGFloat = 16
    private let trailingConstant: CGFloat = -16
    private let photosHeightConstant: CGFloat = 450
    private let leadingAProgressiveViewConstant: CGFloat = 30
    private let trailingProgressiveViewConstant: CGFloat = -30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(photos)
        addSubview(segmentedControll)
        addSubview(stack)
        NSLayoutConstraint.activate([
            segmentedControll.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            segmentedControll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant),
            segmentedControll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant),
            
            photos.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: topConstant),
            photos.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant),
            photos.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant),
            photos.heightAnchor.constraint(equalToConstant: photosHeightConstant),
            
            stack.topAnchor.constraint(equalTo: photos.bottomAnchor, constant: topConstant),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant),
            
            progressiveView.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: leadingAProgressiveViewConstant),
            progressiveView.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: trailingProgressiveViewConstant)
            
        ])
    }
    
    lazy var segmentedControll: UISegmentedControl = {
        let segmentControll = UISegmentedControl(items: ["Последовательно", "Параллельно"])
        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        return segmentControll
    }()
    
    lazy var progressiveView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 0.0
        progress.isHidden = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    
    lazy var photos: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        
        let images = UICollectionView(frame: .zero, collectionViewLayout: layout)
        images.delegate = self
        images.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        images.translatesAutoresizingMaskIntoConstraints = false
        return images
    }()
    
    func configureDataSourceCollectionView(dataSource: UICollectionViewDataSource) {
        photos.dataSource = dataSource
    }
    
    
    lazy var calculationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать вычисление", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stopCalculationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Остановить вычисление", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
            return button
        }()

    
    lazy var calculationLabel: UILabel = {
        let label = UILabel()
        label.text = "Результат будет тут"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [calculationLabel, progressiveView, calculationButton, stopCalculationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    
}
extension MainView: UICollectionViewDelegate {
    
}
    

