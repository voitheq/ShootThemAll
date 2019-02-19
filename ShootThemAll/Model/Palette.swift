//
//  Colors.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 19/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import UIKit

extension UIColor {
    
    private static let colors = [UIColor(red: 250/255, green: 211/255, blue: 144/255, alpha: 1),
                         UIColor(red: 246/255, green: 185/255, blue: 59/255, alpha: 1),
                         UIColor(red: 250/255, green: 152/255, blue: 58/255, alpha: 1),
                         UIColor(red: 229/255, green: 142/255, blue: 38/255, alpha: 1),
                         UIColor(red: 248/255, green: 194/255, blue: 145/255, alpha: 1),
                         UIColor(red: 229/255, green: 80/255, blue: 57/255, alpha: 1),
                         UIColor(red: 235/255, green: 47/255, blue: 6/255, alpha: 1),
                         UIColor(red: 183/255, green: 21/255, blue: 64/255, alpha: 1),
                         UIColor(red: 106/255, green: 137/255, blue: 204/255, alpha: 1),
                         UIColor(red: 74/255, green: 105/255, blue: 189/255, alpha: 1),
                         UIColor(red: 30/255, green: 55/255, blue: 153/255, alpha: 1),
                         UIColor(red: 12/255, green: 36/255, blue: 97/255, alpha: 1),
                         UIColor(red: 130/255, green: 204/255, blue: 221/255, alpha: 1),
                         UIColor(red: 96/255, green: 163/255, blue: 188/255, alpha: 1),
                         UIColor(red: 60/255, green: 99/255, blue: 130/255, alpha: 1),
                         UIColor(red: 10/255, green: 61/255, blue: 98/255, alpha: 1),
                         UIColor(red: 184/255, green: 233/255, blue: 148/255, alpha: 1),
                         UIColor(red: 120/255, green: 224/255, blue: 143/255, alpha: 1),
                         UIColor(red: 56/255, green: 173/255, blue: 169/255, alpha: 1),
                         UIColor(red: 7/255, green: 153/255, blue: 146/255, alpha: 1)]
    
    private static let toComponents = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor.components
    private static var last: Int = -1

    static func getColor() -> UIColor {
        var color: Int
        repeat {
            color = Int.random(in: 0..<colors.count)
        }while color == last
        last = color
        return colors[last]
    }
    
    static func getGradientColor(from: UIColor, percentage: CGFloat) -> UIColor {
        guard percentage >= 0 && percentage <= 1, let fromComponents = from.cgColor.components, let toComponents = toComponents else {
            return UIColor.black
        }
       
        let r = fromComponents[0] + (toComponents[0] - fromComponents[0]) * percentage
        let g = fromComponents[1] + (toComponents[1] - fromComponents[1]) * percentage
        let b = fromComponents[2] + (toComponents[2] - fromComponents[2]) * percentage

        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
