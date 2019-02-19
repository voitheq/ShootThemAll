//
//  SKNode+Extensions.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 11/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

extension SKLabelNode {
    func setFontSizeTo(width: CGFloat, ratio: CGFloat) {
        let size = width * ratio
        fontSize = 1
        while frame.width < size {
            fontSize += 1
        }
        
    }
    
    func setFontSizeTo(height:CGFloat, ratio: CGFloat) {
        let size = height * ratio
        fontSize = 1
        while frame.height < size {
            fontSize += 1
        }
    }
}
