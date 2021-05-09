//
//  IKImage.swift
//  ImageKit
//
//  Created by Harvey on 2021/5/9.
//

import UIKit

extension ImageKit where Base: UIImage {
    
    public enum Position {
        case center
    }
    
    public func add(_ logoImage: UIImage, position: ImageKit.Position = .center) -> UIImage? {
        return drawImage(size: base.size) { (context) in
            let x = (base.size.width - logoImage.size.width) / 2.0
            let y = (base.size.height - logoImage.size.height) / 2.0
            
            context.draw(base.cgImage!, in: .init(origin: .zero, size: base.size))
            context.draw(logoImage.cgImage!, in: .init(origin: .init(x: x, y: y), size: logoImage.size))
        }
    }
    
    public func add(_ logoImageName: String, position: ImageKit.Position = .center) -> UIImage? {
        return add(UIImage(named: logoImageName)!, position: position)
    }
}
