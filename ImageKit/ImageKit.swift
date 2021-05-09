//
//  ImageKit.swift
//  ImageKit
//
//  Created by Harvey on 2021/5/9.
//

import UIKit

public struct ImageKit<Base> {
    
    var base: Base
    fileprivate init(_ base: Base) {
        self.base = base
    }
}

public protocol ImageKitCompatible {
    
    associatedtype CompatibleType
    
    var ik: ImageKit<CompatibleType> { get }
}

public extension ImageKitCompatible {
    
    var ik: ImageKit<Self> {
        get { return ImageKit(self) }
    }
}

extension UIColor: ImageKitCompatible { }
extension Array: ImageKitCompatible { }
extension UIImage: ImageKitCompatible { }

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
