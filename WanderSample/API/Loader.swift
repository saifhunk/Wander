//
//  Loader.swift
//  WanderSample

//  Created by Saif Chaudhary on 15/04/18.
//  Copyright © 2018 Satinder Kumar. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class Loader: NSObject {
    
    static let shared = Loader()
    
    let viewTemp = UIView(frame: UIScreen.main.bounds)
    
    var loader = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.size.width/2 - 22, y: UIScreen.main.bounds.size.height/2 - 22 , w: 44, h: 44) , type: .ballSpinFadeLoader, color: UIColor.yellow , padding: nil)
    
    
    func start() {
        
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        self.viewTemp.addSubview(self.loader)
        
        keyWindow.addSubview(viewTemp)
        keyWindow.bringSubview(toFront: viewTemp)
        self.viewTemp.backgroundColor = UIColor.black.withAlphaComponent(0.24)
        
        self.loader.startAnimating()
        self.viewTemp.isHidden = false
        
    }
    
    func stop() {
        
        self.loader.stopAnimating()
        self.viewTemp.isHidden = true

        
    }
    
    
    
}

