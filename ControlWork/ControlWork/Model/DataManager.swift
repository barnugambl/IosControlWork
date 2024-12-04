//
//  DataManager.swift
//  ControlWork
//
//  Created by Терёхин Иван on 22.11.2024.
//

import Foundation
import UIKit
class DataManager {
    
    private static var photos: [UIImage] = [UIImage(named: "photo1")!, UIImage(named: "photo1")!, UIImage(named: "photo1")!,
                                            UIImage(named: "photo1")!, UIImage(named: "photo1")!, UIImage(named: "photo1")!,
                                            UIImage(named: "photo1")!, UIImage(named: "photo1")!, UIImage(named: "photo1")!,
                                            UIImage(named: "photo1")!, UIImage(named: "photo1")!, UIImage(named: "photo1")!]
        
    static func obtaindPhotos() -> [UIImage] {
        return photos
    }
}
