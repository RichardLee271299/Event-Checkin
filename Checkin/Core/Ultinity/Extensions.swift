//
//  Extensions.swift
//  Checkin
//
//  Created by VNDC on 17/06/2023.
//

import SwiftUI

/// Hỗ trợ tạo Color từ rbg Hex string, và hỗ trợ thông số Alpha
extension Color {
    init(rgb: String, alpha: Double = 1) {
        let rgbHex = rgb.suffix(rgb.count - 1)
        let red = Double(Int(rgbHex.prefix(2), radix: 16) ?? 0) / 255
        let green = Double(Int(rgbHex.prefix(4).suffix(2), radix: 16) ?? 0) / 255
        let blue = Double(Int(rgbHex.suffix(2), radix: 16) ?? 0) / 255
        self.init(
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
    }
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
extension String {
    func encodeCustomizedURL() -> String {
        return (self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "").replacingOccurrences(of: "%3A", with: ":")
    }
}

/// UIImage fix Orientation
extension UIImage {
    var fixedOrientation: UIImage {
        guard imageOrientation != .up else { return self }
        
        var transform: CGAffineTransform = .identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform
                .translatedBy(x: size.width, y: size.height).rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform
                .translatedBy(x: size.width, y: 0).rotated(by: .pi)
        case .right, .rightMirrored:
            transform = transform
                .translatedBy(x: 0, y: size.height).rotated(by: -.pi/2)
        case .upMirrored:
            transform = transform
                .translatedBy(x: size.width, y: 0).scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        guard
            let cgImage = cgImage,
            let colorSpace = cgImage.colorSpace,
            let context = CGContext(
                data: nil, width: Int(size.width), height: Int(size.height),
                bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: cgImage.bitmapInfo.rawValue
            )
        else { return self }
        context.concatenate(transform)
        
        var rect: CGRect
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            rect = CGRect(x: 0, y: 0, width: size.height, height: size.width)
        default:
            rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        
        context.draw(cgImage, in: rect)
        return context.makeImage().map { UIImage(cgImage: $0) } ?? self
    }
}
extension String {
    var isNumber: Bool {
        return self.range(
            of: "^[0-9]*$", // 1
            options: .regularExpression) != nil
    }
}
