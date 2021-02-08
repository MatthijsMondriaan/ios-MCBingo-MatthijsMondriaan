//
//  Color.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 08/02/2021.
//

#if os(macOS) || os(iOS) || os(tvOS)
import CoreImage
#endif

#if os(macOS)
import AppKit
#elseif os(iOS) || os(tvOS)
import UIKit
#endif


// MARK: - Color struct
/// Color struct, holds red, green, blue and alpha as CGFloats. (32 bytes in total (yes, CGFloats are 64-bits))
public struct Color {
    
    public var red: CGFloat = 0
    public var green: CGFloat = 0
    public var blue: CGFloat = 0
    public var alpha: CGFloat = 1
    
    public init() {}
    
    // Initialize with CGFloats.
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    // Initialize with CGFloats (nameless).
    public init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) {
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Initialize with Ints.
    public init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    // Initialize with Ints (nameless).
    public init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    // Initialize grayscale (and alpha) with an Int (and CGFloat) (nameless).
    public init(_ gray: Int, alpha: CGFloat = 1.0) {
        let fgray = CGFloat(gray) / 255.0
        self.init(red: fgray, green: fgray, blue: fgray, alpha: alpha)
    }
    
    // Initialize grayscale (and alpha) with a CGFloat (nameless).
    public init(_ gray: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: gray, green: gray, blue: gray, alpha: alpha)
    }
    
    // Initialize with a single 32-bit UInt (nameless). Useful for HEX codes! E.g: Color(0xFF8800) or Color(0xFF8800FF).
    public init(_ color: UInt32) {
        if color <= (UInt32.max >> 8) { // RGB
            self.init(
                red: CGFloat(color >> 16 & 0xFF) / 0xFF,
                green: CGFloat(color >> 8 & 0xFF) / 0xFF,
                blue: CGFloat(color & 0xFF) / 0xFF
            )
        }
        else { // RGBA
            self.init(
                red: CGFloat(color >> 24 & 0xFF) / 0xFF,
                green: CGFloat(color >> 16 & 0xFF) / 0xFF,
                blue: CGFloat(color >> 8 & 0xFF) / 0xFF,
                alpha: CGFloat(color & 0xFF) / 0xFF
            )
        }
    }
    
    // Initialize with a string representing a 32 or 24-bit integer in hex.
    public init(_ color: String) {
        var string = color.lowercased()
        if string.hasPrefix("#") {
            let substring = string[string.index(string.startIndex, offsetBy: 1)...]
            string = String(substring)
        }
        
        let value = UInt32(string, radix: 16) ?? UInt32(0)
        self.init(value)
    }
    
    // Initialize with CGColor (nameless)
    public init(_ color: CGColor) {
        let mem = color.components
        self.init(
            red: mem?[0] ?? 0,
            green: mem?[1] ?? 0,
            blue: mem?[2] ?? 0,
            alpha: mem?[3] ?? 1
        )
    }
    
    // Initialize with Color and modified channels.
    public init(_ color: Color, red: CGFloat? = nil, green: CGFloat? = nil, blue: CGFloat? = nil, alpha: CGFloat? = nil) {
        self.init(red: red ?? color.red,
                  green: green ?? color.green,
                  blue: blue ?? color.blue,
                  alpha: alpha ?? color.alpha)
    }
    
    // Initialize with CIColor (nameless)
    public init(_ color: CIColor) {
        self.init(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)
    }
    
    public var cg: CGColor {
        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [red, green, blue, alpha])!
    }
    
    public var ci: CIColor {
        return CIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public var hex: String {
        return [red, green, blue, alpha].map { channel in
            let string = String(format: "%X", Int(channel * 255.0))
            return string.count == 1 ? "0" + string : string
            }.joined(separator: "")
    }
    
    public var int: Int32 {
        let r = Int32(red * 0xFF)
        let g = Int32(green * 0xFF)
        let b = Int32(blue * 0xFF)
        let a = Int32(alpha * 0xFF)
        return (((((r << 8) | g) << 8) | b) << 8) | a
    }
}

public func == (left: Color, right: Color) -> Bool {
    return left.red == right.red
        && left.green == right.green
        && left.blue == right.blue
        && left.alpha == right.alpha
}

extension Color: CustomStringConvertible {
    public var description: String {
        return "Red: \(red), green: \(green), blue: \(blue), alpha: \(alpha)"
    }
}

public func mix(_ from: Color, with: Color, at: CGFloat) -> Color {
    let mix = { (from: CGFloat, with: CGFloat, at: CGFloat) -> CGFloat in from + ((with - from) * at) }
    return Color(
        mix(from.red, with.red, at),
        mix(from.green, with.green, at),
        mix(from.blue, with.blue, at),
        mix(from.alpha, with.alpha, at)
    )
}

extension Color: Hashable {
    /// Basically returns the HEX code.
    public func hash(into hasher: inout Hasher) {
        let r = Int(red * 255) << 24
        let g = Int(green * 255) << 16
        let b = Int(blue * 255) << 8
        let a = Int(alpha * 255)
        return hasher.combine(r | g | b | a)
    }
}


// MARK: - Color extensions.
extension Color {
    #if os(macOS)
    public init(_ color: NSColor) {
        self.init(red: color.redComponent, green: color.greenComponent, blue: color.blueComponent, alpha: color.alphaComponent)
    }
    
    public var ns: NSColor {
        return NSColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    #elseif os(iOS) || os(watchOS) || os(tvOS)
    
    public init(_ color: UIColor) {
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
    
    public var ui: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    #endif
}

extension Color: Codable {
    enum ColorError: String, Error {
        case notEnoughElements = "Not enough elements."
        case invalidNumberOfElements = "Element count exceeds 4."
    }
    
    /**
     * `Color` is encoded to an array of 4 Doubles.
     * `Color` can be decoded from an array containing 1 to 4 Doubles.
     * Or from a hexidecimal string.
     */
    public init(from decoder: Decoder) throws {
        // Try string first.
        do {
            let singleValue = try decoder.singleValueContainer()
            let string = try singleValue.decode(String.self)
            let tmpColor = Color(string)
            
            red = tmpColor.red
            green = tmpColor.green
            blue = tmpColor.blue
            alpha = tmpColor.alpha
            
            return
        }
        catch {}
        
        var container = try decoder.unkeyedContainer()
        
        guard let count = container.count, count > 0 else {
            throw ColorError.notEnoughElements
        }
        
        if count <= 2 {
            let rgb = try container.decode(CGFloat.self)
            red = rgb
            green = rgb
            blue = rgb
            
            if count == 2 {
                alpha = try container.decode(CGFloat.self)
            }
        }
        else if count <= 4 {
            red = try container.decode(CGFloat.self)
            green = try container.decode(CGFloat.self)
            blue = try container.decode(CGFloat.self)
            
            if count == 4 { // [R, G, B, A]
                alpha = try container.decode(CGFloat.self)
            }
        }
        else {
            throw ColorError.invalidNumberOfElements
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        let rgba = [red, green, blue, alpha]
        try rgba.encode(to: encoder)
    }    
}


// MARK: - ColorGradient struct.
/// Create a linear or radial gradient based on *n* amount of colors.
/// Can export a CGGradient and CAGradientLayer if you so desire.
public struct ColorGradient {
    
    public enum GradientType {
        case linear, radial
    }
    
    public typealias Segment = (color: Color, location: CGFloat)
    
    public var angle: CGFloat = 0
    
    public var segments: [Segment]
    
    public var type = GradientType.linear
    
    public init(segments: [Segment], type: GradientType = .linear, angle: CGFloat = 0) {
        self.angle = angle
        self.segments = segments
        self.type = type
    }
    
    public func layer(_ frame: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = segments.map { $0.color.cg }
        gradient.frame = frame
        gradient.locations = segments.map { $0.location as NSNumber }
        gradient.type = type == .linear ? .axial : .radial
        
        if type == .linear {
            let xdist = cos(angle * (.pi / 180)) * 0.5
            let ydist = sin(angle * (.pi / 180)) * 0.5
            gradient.startPoint = CGPoint(x: 0.5 - xdist, y: 0.5 - ydist)
            gradient.endPoint = CGPoint(x: 0.5 + xdist, y: 0.5 + ydist)
        }
        else if type == .radial {
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.5)
        }
        
        return gradient
    }
    
    public var CG: CGGradient {
        let locations = segments.map { $0.location }
        
        var colors: [CGFloat] = []
        for (color, _) in segments {
            colors += [color.red, color.green, color.blue, color.alpha]
        }
        
        let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: colors, locations: locations, count: segments.count)!
        return gradient
    }
    
}

public func == (left: ColorGradient, right: ColorGradient) -> Bool {
    if left.segments.count != right.segments.count {
        return false
    }
    
    for i in 0 ..< left.segments.count {
        if left.segments[i].color != right.segments[i].color || left.segments[i].location != right.segments[i].location {
            return false
        }
    }
    
    return true
}

extension ColorGradient: Hashable {
    public func hash(into hasher: inout Hasher) {
        segments.forEach { segment in
            hasher.combine(segment.color)
            hasher.combine(segment.location)
        }
    }
}

extension ColorGradient: CustomStringConvertible {
    public var description: String {
        var description = ""
        for segment in segments {
            description += segment.color.description + "\(segment.location)"
        }
        return description
    }
}


// MARK: - UIImage/NSImage + ColoredImage.
// Extensions for UIImage. (NSImage on OSX)
#if os(macOS)
    public typealias PlatformAgnosticImage = NSImage
#else
    public typealias PlatformAgnosticImage = UIImage
#endif
public extension PlatformAgnosticImage {
    
    /// Keep a weak reference to the colored image. Their key being the RGBA code as string.
    private static let dataBank = NSMapTable<NSString, PlatformAgnosticImage>(keyOptions: .strongMemory, valueOptions: .weakMemory)
    
    /// Colored image (based on a black/white image) filled with the given color.
    static func coloredImage(named name: String, color: Color) -> PlatformAgnosticImage? {
        let keyName = name + color.description as NSString
        
        if let image = dataBank.object(forKey: keyName) {
            return image
        }
        else if let image = PlatformAgnosticImage(named: name) {
            return modifyImage(image) { ctx, rect in
                ctx.setFillColor(color.cg)
                ctx.fill(rect)
            }
        }
        
        return nil
    }
    
    /// Colored image (based on a black/white image) filled with the given gradient.
    static func coloredImage(named name: String, gradient: ColorGradient) -> PlatformAgnosticImage? {
        let keyName = name + gradient.description as NSString
        
        if let image = dataBank.object(forKey: keyName) {
            return image
        }
        else if let image = PlatformAgnosticImage(named: name) {
            return modifyImage(image) { ctx, rect in
                let cggradient = gradient.CG
                if gradient.type == .linear {
                    let xdist = cos(gradient.angle * (.pi / 180)) * 0.5
                    let ydist = sin(gradient.angle * (.pi / 180)) * 0.5
                    let startPoint = CGPoint(x: (0.5 - xdist) * rect.size.width, y: (0.5 - ydist) * rect.size.height)
                    let endPoint = CGPoint(x: (0.5 + xdist) * rect.size.width, y: (0.5 + ydist) * rect.size.height)
                    
                    ctx.drawLinearGradient(cggradient, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
                }
                else if gradient.type == .radial {
                    ctx.drawRadialGradient(cggradient, startCenter: CGPoint(), startRadius: 0, endCenter: CGPoint(), endRadius: 1, options: .drawsBeforeStartLocation)
                }
            }
        }
        
        return nil
    }
    
    /// Helper to modify the image. All drawing is done in the `block` closure.
    private static func modifyImage(_ image: PlatformAgnosticImage, block: (CGContext, CGRect) -> ()) -> PlatformAgnosticImage? {
        #if os(iOS) || os(tvOS)
            guard let cgimage = image.cgImage else {
                return nil
            }
            
            let scale = image.scale
            
            let width = Int(image.size.width * scale)
            let height = Int(image.size.height * scale)
            let rect = CGRect(x: 0, y: 0, width: width, height: height)
            
            let ctx = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4 * width, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
            ctx.clip(to: rect, mask: cgimage)
            block(ctx, rect)
            
            if let finalCGImage = ctx.makeImage() {
                return PlatformAgnosticImage(cgImage: finalCGImage, scale: image.scale, orientation: image.imageOrientation)
            }
        #endif
        
        return nil
    }
    
}
