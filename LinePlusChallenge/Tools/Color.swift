//
//  Color.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/19.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

struct Color {
    
    var violet: String {
        return "#9013FE"
    }
    
    var lightBlack: String {
        return "#141428"
    }
    
    var whiteAndBlack: String {
        return "#A3A3B5"
    }
    
    var darkGray: String {
        return "#ABABC4"
    }
    
    var grayWhite: String {
        return "#ECECF5"
    }
    
    var lightWhite: String {
        return "#F6F6FA"
    }
    
    var black: String {
        return "#000000"
    }
    
    var lightGray: CGColor {
        return UIColor.rgb(r: 24, g: 24, b: 80, a: 0.04).cgColor
    }
    
}

extension UIColor {
    
    static func rgb(r red: CGFloat, g green: CGFloat, b blue: CGFloat, a alpha: CGFloat = 1.0) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func colorWithHexString(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        // Convert hex string to an integer
        var hexInt: UInt64 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexString)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt64(&hexInt)
        
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

}
