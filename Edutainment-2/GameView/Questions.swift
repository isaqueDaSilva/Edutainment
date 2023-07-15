//
//  Questions.swift
//  Edutainment-2
//
//  Created by Isaque da Silva on 15/07/23.
//

import Foundation

struct Questions {
    var difficultyLevel: DifficultyLevel
    
    var multiplier: Int {
        var numbers = [Int]()
        
        if difficultyLevel == .easy {
            numbers = [1, 2, 3, 4, 5, 10, 20]
        } else if difficultyLevel == .medium {
            numbers = [6, 7, 8, 15]
        } else if difficultyLevel == .hard {
            numbers = [9, 11, 13, 14, 16, 17, 18, 19]
        }
        return numbers.randomElement() ?? 0
    }
    
    var multiplying: Int {
        var numbers = [Int]()
        
        if difficultyLevel == .easy {
            numbers = [1, 2, 5, 10]
        } else if difficultyLevel == .medium {
            numbers = [3, 4, 6]
        } else if difficultyLevel == .hard {
            numbers = [7, 8, 9]
        }
        
        return numbers.randomElement() ?? 0
    }
    
    func questionGenerator() -> String {
        return "How Much is \(multiplier) x \(multiplying)"
    }
}
