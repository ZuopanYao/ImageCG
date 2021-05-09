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
}

public extension ImageCGCompatible {
    
    var icg: ImageCG<Self> {
        get { return ImageCG(self) }
    }
}

extension UIColor: ImageCGCompatible { }
extension Array: ImageCGCompatible { }
extension UIImage: ImageCGCompatible { }

func drawImage(size: CGSize, _ draw: ((CGContext) -> Void)) -> UIImage? {
    
    UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
    guard let context  = UIGraphicsGetCurrentContext() else {
        UIGraphicsEndImageContext()
        return nil
    }
    
    draw(context)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}