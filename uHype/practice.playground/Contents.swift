//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func longestSequence(input : String) -> String {
    
    var currentSequence = ""
    var maxSoFar = ""
    
    var characters = Array(input.characters)

    for i in 0...characters.count-2 {
        currentSequence = currentSequence + String(characters[i])
        if characters[i+1] < characters[i] {
            
            if maxSoFar.characters.count < currentSequence.characters.count {
                maxSoFar = currentSequence
            }
            currentSequence = ""
        }
        print(characters[i])
    }
    
    return maxSoFar
    
}

longestSequence(input: "azcbobobegghakl")
