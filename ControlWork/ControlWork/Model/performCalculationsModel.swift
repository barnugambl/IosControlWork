//
//  CalculateFactorial.swift
//  ControlWork
//
//  Created by Терёхин Иван on 22.11.2024.
//

import Foundation

class performCalculationsModel {
    
    func factorial(number: Int, progressHandler: @escaping (Float) -> Void, resultHandler: @escaping (String) -> Void) async throws {
        var resultNumber = 1
        for i in 1...number {
            resultNumber *= i
            let currentProgress = Float(i) / Float(number)
            await MainActor.run { [resultNumber] in
                resultHandler("Факториал \(i) = \(resultNumber)")
                progressHandler(currentProgress)
            }
            try await Task.sleep(nanoseconds: 1_000_000_000)
        }
    }
}
