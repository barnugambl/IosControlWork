//
//  PhotoProcessing.swift
//  ControlWork
//
//  Created by Терёхин Иван on 03.12.2024.
//

import UIKit

class PhotoProcessing {
    private var context = CIContext()
    var images = DataManager.obtaindPhotos()
    
    func applyRandomFilter(image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        let filters = ["CISepiaTone", "CIColorInvert"]
        guard let currentFilter = CIFilter(name: filters.randomElement()!) else { return nil }
        currentFilter.setValue(ciImage, forKey: kCIInputImageKey)
        if let outputImage = currentFilter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
    
    func processImagesParallel(updateImage: @escaping (Int) -> Void) {
        let dispatchGroup = DispatchGroup()
        images.enumerated().forEach { index, image in
            dispatchGroup.enter()
            DispatchQueue.global().async { [weak self] in
                if let filtered = self?.applyRandomFilter(image: image) {
                    DispatchQueue.main.async { [weak self] in
                        self?.images[index] = filtered
                        updateImage(index)
                        dispatchGroup.leave()
                    }
                }
            }
        }
    }
    
    func processImagesSequential(updateImage: @escaping (Int) -> Void) {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        
        images.enumerated().forEach { index, image in
            let operation = BlockOperation { [weak self] in
                if let filtered = self?.applyRandomFilter(image: image) {
                    DispatchQueue.main.async { [weak self] in
                        self?.images[index] = filtered
                        updateImage(index)
                    }
                }
            }
            operationQueue.addOperation(operation)
        }
    }
}


