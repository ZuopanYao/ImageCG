//
//  ImageCG.swift
//  ImageCG
//
//  Created by Harvey on 2021/5/9.
//

import UIKit

public struct ImageCG<Base> {
    
    var base: Base
    fileprivate init(_ base: Base) {
        self.base = base
    }
}

public protocol ImageCGCompatible {
    
    associatedtype CompatibleType
    
    var icg: ImageCG<CompatibleType> { get }
    static var icg: ImageCG<CompatibleType>.Type { get }
}

public extension ImageCGCompatible {
    
    var icg: ImageCG<Self> { ImageCG(self) }
    static var icg: ImageCG<Self>.Type {  ImageCG<Self>.self }
}

extension UIColor: ImageCGCompatible { }
extension Array: ImageCGCompatible { }
extension UIImage: ImageCGCompatible { }

func drawImage(size: CGSize, isOpaque: Bool = false, _ draw: ((CGContext) -> Void)) -> UIImage? {
    defer { UIGraphicsEndImageContext() }
    UIGraphicsBeginImageContextWithOptions(size, isOpaque, UIScreen.main.scale)
    guard let context  = UIGraphicsGetCurrentContext() else {
        return nil
    }
    draw(context)
    return UIGraphicsGetImageFromCurrentImageContext()
}
