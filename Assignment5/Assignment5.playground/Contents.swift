//: Playground - noun: a place where people can play

import UIKit

let daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
let daysInYear = 365

func isLeap(year:Int) -> Bool {
    return year%4 == 0 ? ((year%100 == 0  && year%400 != 0) ? false : true) : false
}

func julianDate (year:Int, month:Int, day:Int) -> Int {
    
    let daysFromYears = (1900..<year).map {isLeap($0) ? daysInYear + 1 : daysInYear}.reduce(0) { $0 + $1 }
    
    let daysFromMonths = (1..<month).map {isLeap(year) && $0 == 2 ? daysInMonth[$0-1] + 1 : daysInMonth[$0-1]}.reduce(0) { $0 + $1 }
    
    return daysFromYears + daysFromMonths + day
    
}

julianDate (1960, month: 9, day: 28)

julianDate (1900, month: 1, day: 1)

julianDate (1900, month: 12, day: 31)

julianDate (1901, month: 1, day: 1)

julianDate (1901, month: 1, day: 1) - julianDate (1900, month: 1, day: 1)

julianDate (2001, month: 1, day: 1) - julianDate (2000, month: 1, day: 1)


isLeap(1960)

isLeap(1900)

isLeap(2000)
