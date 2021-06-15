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
    
    
    /// 读取 PDF 并转为 UIImage
    /// - Parameters:
    ///   - filePath: PDF 路径
    ///   - isJoin: 是否进行拼接，ture = 拼接成一张图片，false = 一页一张图片
    ///   - color: 填充背景颜色
    /// - Returns: 数组 [UIImage]
    public static func readPDF(from filePath: String, isJoin: Bool = true, fill color: UIColor = .white) -> [UIImage?] {
        let data = readPDF(from: filePath, fill: color)
        guard isJoin else { return data.0 }
        return [pdfJoin(from: data)]
    }
    
    static func pdfJoin(from data: ([UIImage?], CGSize)) -> UIImage? {
        return (drawImage(size: data.1, isOpaque: true) { (_) in
            var offsetY: CGFloat = 0.0
            for image in data.0 {
                guard let image = image else { continue }
                image.draw(in: CGRect(origin: .init(x: 0, y: offsetY), size: image.size))
                offsetY += image.size.height
            }
        })
    }
    
    static func readPDF(from filePath: String, fill color: UIColor = .white) -> ([UIImage?], CGSize) {
        guard let pdf = CGPDFDocument(URL(fileURLWithPath: filePath) as CFURL) else { return ([], .zero) }
        
        var images: [UIImage?] = []
        let pageRect: CGRect = pdf.page(at: 1)!.getBoxRect(.mediaBox)
        
        _ = drawImage(size: pageRect.size, isOpaque: true, { (context) in
            for index in 1...pdf.numberOfPages {
                context.saveGState()
                color.setFill()
                context.fill(CGRect(origin: .zero, size: pageRect.size))
                
                let pdfPage: CGPDFPage = pdf.page(at: index)!
                context.translateBy(x: 0.0, y: pageRect.size.height)
                context.scaleBy(x: 1.0, y: -1.0)
                context.concatenate(pdfPage.getDrawingTransform(.mediaBox, rect: pageRect, rotate: 0, preserveAspectRatio: true))
                context.drawPDFPage(pdfPage)
                images.append(UIGraphicsGetImageFromCurrentImageContext())
                context.clear(pageRect)
                context.restoreGState()
            }
        })
        
        return (images, CGSize(width: pageRect.size.width, height: pageRect.size.height * CGFloat(pdf.numberOfPages)))
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
