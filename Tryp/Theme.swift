//
//  Theme.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/10/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit

struct Theme {
    static func apply(to window: UIWindow) {
      
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = .black
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    struct Colors {
        
        static var black30 = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.3)
        static var warmGrey = UIColor(red:151.0, green:151.0, blue:151.0, alpha:1)
        static var warmGreyTwo = UIColor(red:129.0, green:129.0, blue:129.0, alpha:1)
    }
}
