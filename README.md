# ImageCG

iOS 绘图(CoreGraphics)

[![Platform](https://img.shields.io/cocoapods/p/ImageCG.svg?style=flat)](https://github.com/ZuopanYao/ImageCG)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/ImageCG.svg)](https://cocoapods.org/pods/ImageCG)

## Requirements / 使用条件

- iOS 11.0+  
- Xcode 12.2+
- Swift 5.0+


## Installation / 安装

### CocoaPods

```
pod 'ImageCG'
```

### Manually / 手动安装

If you prefer not to use either of the aforementioned dependency managers, you can integrate ImageCG into your project manually.

如果您不喜欢以上管理依赖库的方式，则可以手动将 ImageCG 集成到项目中。


## Usage / 使用

### UIColor to UIImage

```
let image = UIColor.red.icg.image(CGSize(width: 200, height: 100))

```

### UIImage zoom

```
let newImage = myImage.icg.zoom(to: CGSize(width: 200, height: 100))

```

###  UIImage add UIImage 在图片上添加图片

```
let baseImage = UIImage(named: "BaseImageName")!
let logoImage = UIImage(named: "LogoImageName")!
let image = baseImage.icg.add(logoImage)
```

### Linear Gradient 线性渐变

```
let colors = [UIColor.blue, UIColor.red, UIColor.yellow, ...]
let image = colors.icg.linearGradient(CGSize(width: 200, height: 100), 
direction: .diagonally)

```

### Radial Gradient 径向渐变

```
let colors = [UIColor.blue, UIColor.red, UIColor.yellow, ...]
let image = colors.icg.radialGradient(CGSize(width: 200, height: 100), 
direction: .diagonally)

```

## License / 许可证

ImageCG is released under the MIT license. See LICENSE for details.

ImageCG 是在 MIT 许可下发布的，有关详情请查看该许可证。