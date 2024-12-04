//
//  ViewController.swift
//  ControlWork
//
//  Created by Терёхин Иван on 22.11.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var mainView: MainView = MainView(frame: .zero)
    private let dataSourceCollection = CollectionViewDataSource()
    private let calculation = performCalculationsModel()
    private var photo = DataManager.obtaindPhotos()
    private let photoProcessing = PhotoProcessing()
    private var task: Task<Void, Never>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewDataSource()
        setupActionButtons()
        setupSegmentControlChange()
    }
    
    override func loadView() {
        view = mainView
    }
    
    private lazy var startButtonAction: UIAction = {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            self.startCalculation()
            
        }
    }()
    
    private lazy var canselButtonAction: UIAction = {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            self.cancelCalculation()
        }
    }()
    
    private func startCalculation()  {
        mainView.calculationButton.isHidden = true
        mainView.stopCalculationButton.isHidden = false
        mainView.progressiveView.isHidden = false
        task = Task {
            do {
                try await calculation.factorial(number: 20) { progress in
                    self.mainView.progressiveView.progress = progress
                } resultHandler: { result in
                    self.mainView.calculationLabel.text = result
                }
            } catch {
                print("Вычисления были завершены")
            }
        }
    }
    
    
    private func cancelCalculation()  {
        task?.cancel()
        mainView.calculationButton.isHidden = false
        mainView.stopCalculationButton.isHidden = true
        mainView.progressiveView.isHidden = true
        mainView.progressiveView.progress = 0.0
        mainView.calculationLabel.text = "Вычисления отменены"
    }
    
    private func setupActionButtons() {
        mainView.calculationButton.addAction(startButtonAction, for: .touchUpInside)
        mainView.stopCalculationButton.addAction(canselButtonAction, for: .touchUpInside)
    }
    
    private func setupCollectionViewDataSource() {
        mainView.photos.dataSource = dataSourceCollection
    }
    
    private func setupSegmentControlChange() {
        mainView.segmentedControll.addTarget(self, action: #selector(segmentControlValueChange), for: .valueChanged)
    }
    
    @objc private func segmentControlValueChange() {
        switch mainView.segmentedControll.selectedSegmentIndex {
        case 0:
            photoProcessing.processImagesSequential { [weak self] index in
                let indexPath = IndexPath(item: index, section: 0)
                self?.dataSourceCollection.updateImages(self?.photoProcessing.images ?? [])
                self?.mainView.photos.reloadItems(at: [indexPath])
            }
            
        case 1:
            photoProcessing.processImagesParallel { [weak self ] index in
                let indexPath = IndexPath(item: index, section: 0)
                self?.dataSourceCollection.updateImages(self?.photoProcessing.images ?? [])
                self?.mainView.photos.reloadItems(at: [indexPath])
            }
            
        default:
            break
        }
    }
}
