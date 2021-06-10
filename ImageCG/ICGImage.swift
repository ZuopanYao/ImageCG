//
//  ICGImage.swift
//  ImageCG
//
//  Created by Harvey on 2021/5/9.
//

import UIKit

extension ImageCG where Base: UIImage {
    
    public enum Position {
        case center
    }
    
    public func add(_ logoImage: UIImage, position: ImageCG.Position = .center) -> UIImage? {
        return drawImage(size: base.size) { (context) in
            let x = (base.size.width - logoImage.size.width) / 2.0
            let y = (base.size.height - logoImage.size.height) / 2.0
            
            context.draw(base.cgImage!, in: .init(origin: .zero, size: base.size))
            context.draw(logoImage.cgImage!, in: .init(origin: .init(x: x, y: y), size: logoImage.size))
        }
    }
    
    public func add(_ logoImageName: String, position: ImageCG.Position = .center) -> UIImage? {
        return add(UIImage(named: logoImageName)!, position: position)
    }
    
    /// 缩放到指定大小
    public func zoom(to size: CGSize) -> UIImage? {
        return drawImage(size: size) { (context) in
            context.draw(base.cgImage!, in: CGRect(origin: .zero, size: size))
        }
    }
}
