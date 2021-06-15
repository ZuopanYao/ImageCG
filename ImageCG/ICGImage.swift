//
//  ICGImage.swift
//  ImageCG
//
//  Created by Harvey on 2021/5/9.
//

import UIKit
import CoreGraphics

extension ImageCG where Base: UIImage {
    
    public enum Position {
        case center
    }
    
    public func add(_ logoImage: UIImage, position: ImageCG.Position = .center) -> UIImage? {
        return drawImage(size: base.size) { (_) in
            let x = (base.size.width - logoImage.size.width) / 2.0
            let y = (base.size.height - logoImage.size.height) / 2.0
            
            base.draw(in: .init(origin: .zero, size: base.size))
            logoImage.draw(in: .init(origin: .init(x: x, y: y), size: logoImage.size))
        }
    }
    
    public func add(_ logoImageName: String, position: ImageCG.Position = .center) -> UIImage? {
        return add(UIImage(named: logoImageName)!, position: position)
    }
    
    /// 缩放到指定大小
    public func zoom(to size: CGSize) -> UIImage? {
        return drawImage(size: size) { (_) in
            base.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    /// 裁剪
    public func clip(in rect: CGRect) -> UIImage? {
        guard let subImage = base.cgImage?.cropping(to: rect.pixel(base.scale)) else { return nil }
        return UIImage(cgImage: subImage, scale: base.scale, orientation: .up)
    }
    
    /// to UIColor
    public var color: UIColor? {
        UIColor(patternImage: base)
    }
}

extension CGRect {
    
    func pixel(_ scale: CGFloat) -> CGRect {
        return .init(x: origin.x * scale,
                     y: origin.y * scale,
                     width: size.width * scale,
                     height: size.height * scale)
    }
}
