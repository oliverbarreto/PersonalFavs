//
//  Utils.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 27/5/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import Foundation

// Returns a random number in the range of (0..<n)
func randomInt(_ n:Int) -> Int
{
    return Int(arc4random_uniform(UInt32(n)))
}

// Returns a random number in the range of (from..<to)
func randomInRange(from: Int, to: Int) -> Int {
    return Int(arc4random_uniform(UInt32(to + 1 - from))) + from
}

/*
//  Make a variable equal to a random number....

let randomNum:UInt32 = arc4random_uniform(100) // range is 0 to 99

// convert the UInt32 to some other  types

let randomTime:TimeInterval = TimeInterval(randomNum)

let someInt:Int = Int(randomNum)

let someString:String = String(randomNum) //string works too
*/
