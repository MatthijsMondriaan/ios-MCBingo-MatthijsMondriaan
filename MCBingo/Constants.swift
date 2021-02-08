//
//  Constants.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 31/01/2021.
//

import UIKit

enum Constants {
    static let smallCornerRadius: CGFloat = 6.0
    static let mediumCornerRadius: CGFloat = 10.0
    static let bigCornerRadius: CGFloat = 20.0
}

enum Colors {
    static let black = Color(10)
    static let gray = Color(140)
    static let red = Color(255, 51, 0)
    static let darkRed = Color(239, 48, 1)
    static let whiteColor = UIColor.white
    static let textColor = UIColor.white
    static let dimmedTextColor = UIColor.white.withAlphaComponent(0.75)
    static let dimmedGrayColor = UIColor(red:0.890, green:0.890, blue:0.890, alpha:1.000)
    static let dimmedBlackColor = Color(10).ui
    static let redColor = UIColor(red:0.663, green:0.133, blue:0.135, alpha:1.000)
    static let greenColor = UIColor(red:0.00, green:0.40, blue:0.20, alpha:1.0)
    static let blueColor = UIColor(red:0.010, green:0.248, blue:0.512, alpha:1.000)
    static let orangeColor = UIColor(red:0.842, green:0.549, blue:0.003, alpha:1.000)
    static let lineColor = UIColor(red:0.337, green:0.337, blue:0.333, alpha:1.000)
    static let navigationBarBackgroundColor = UIColor(red:0.006, green:0.514, blue:0.266, alpha:0.5)
    static let semiTransparentGreenBackgroundColor = UIColor(red:0.00, green:0.40, blue:0.20, alpha:0.8)
    static let semiTransparentBlackBackgroundColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha:0.5)
    static let ultraLightGreenColor = UIColor(red:0.889, green:0.923, blue:0.853, alpha:1.000)
    static let statusIndicatorGreenColor = Color(100, 154, 10)
    static let statusIndicatorYellowColor = Color(239, 183, 0)
    static let statusIndicatorRedColor = Color(221, 0, 0)
    static let statusIndicatorGrayColor = Color(212, 212, 212)
    static let appleSystemLightBlueColor = Color(0, 122, 255)
    static let appleSystemDarkBlueColor = Color(10, 132, 255)
}
