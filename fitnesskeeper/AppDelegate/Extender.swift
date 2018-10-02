//
/*------------------------------------------------------------------------------
  
  This source is part of the Thaw Zin Oo and Team Members.
  Copyright  2018,2019, Thaw Zin Oo and/or its affiliates. All rights reserved.
  
  No part of this work may be reproduced, stored in a retrieval system,
  adopted or transmitted in any form or by any means, electronic, mechanical,
  photographic, graphic, optic recording or otherwise, translated in any language
  or computer language, without the prior written permission of Thaw Zin Oo and its affiliates.
  

  Yangon,
  Myanmar.
  
  Modification History
  
  Date        Version        Author               Description
  ----------  -----------    ---------------      ----------------------------------------
  <#Date DD/MM/YYYY#>  <#1.0#>            <#Your Name#>        Initial Version
  
  
  ------------------------------------------------------------------------------*/

import Foundation
import AVFoundation

import NVActivityIndicatorView
import UIKit
//import Charts



//MARK: Utilities of Global Class
extension NSObject {
    var className:String {
        return String(describing:type(of:self))
    }
}

//MARK: Date Extension






//MARK: Data Extension
extension Data {
    
    mutating func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

extension Float {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
    var integer:Int {
        return Int(self)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var integer:Int {
        return Int(self)
    }
}
//Mark disclosure color
extension UITextField {
    func underlined(backgroundColor:UIColor, _ color:UIColor? = UIColor.white ){
        
        self.borderStyle = .none
        self.layer.backgroundColor = backgroundColor.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color!.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension UITableView  {
    func sizeHeaderToFit() {
        if let headerView = self.tableHeaderView {
            
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var frame = headerView.frame
            frame.size.height = height
            headerView.frame = frame
            
            self.tableHeaderView = headerView
        }
    }
    
    func sizeFooterToFit() {
        if let footerView = self.tableFooterView {
            footerView.setNeedsLayout()
            footerView.layoutIfNeeded()
            
            let height = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var frame = footerView.frame
            frame.size.height = height
            footerView.frame = frame
            
            self.tableFooterView = footerView
        }
    }
}
extension UITableViewCell {
    
    func setDisclosure(toColour: UIColor) -> () {
        for view in self.subviews {
            if let disclosure = view as? UIButton {
                if let image = disclosure.backgroundImage(for: .normal) {
                    // let colouredImage = UIImage(named: "<#T##String#>")
                    let colouredImage = image.withRenderingMode(.alwaysTemplate);
                    disclosure.setImage(colouredImage, for: .normal)
                    disclosure.tintColor = toColour
                }
            }
        }
    }
}


extension NSNumber {
    
    var chineseNumberString:String?{
        
        let userLocale = Locale(identifier: "zh_Hans_CN")
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = userLocale
        return formatter.string(from: self)
    }
    
}

extension Int{
    var exerciseCategory:String{
        switch self {
        case 1:
            return "基本體能"
        case 2:
            return "肌力訓練"
        case 3:
            return "爆發力訓練"
        case 4:
            return "協調性訓練"
        case 5:
            return "柔軟度訓練"
        case 6:
            return "燃脂訓練"
            //  case 7:
        //    return "運動處方"
        case 8:
            return "自訂運動選單"// "自訂運動菜單"
        case 9:
            return "熱量消耗查詢"
        default:
            return ""
        }
    }
    var fileSizeString:String{
        var value:Double = Double(self)
        var tokens = ["bytes","KB","MB","GB","TB","PB","EB","ZB","YB"]
        var multiplyFactor = 0
        while value > 1024 {
            value /= 1024
            multiplyFactor += 1
        }
        return String(format: "%4.2f %@", arguments: [value,tokens[multiplyFactor]])
    }
}


extension UILabel {
    func addCharacterSpacing(_ value:CGFloat = 1.15) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}


extension UIImage
{
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage
    {
        let drawRect = CGRect(x:0.0, y:0.0,width: size.width, height:size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context!.clip(to: drawRect, mask: CGImage.self as! CGImage)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}

extension UIButton {
    func setInactive() {
        self.isEnabled = false
        
        self.layer.borderWidth = 1.0
        self.backgroundColor = UIColor.white
        
    }
    func setActive() {
        self.isEnabled = true
        //self.layer.borderColor = DefaultColor.disableLoginButtonColor.cgColor
        self.layer.borderWidth = 1.0
        
    }
}

extension UIBarButtonItem {
    func addTarget (_ target:Any?  ,  action barAction:(Selector)  ,for  event:UIControlEvents  ) {
        if let btn =  self.customView as? UIButton {
            btn.addTarget(target, action: barAction, for: event)
        }
        else {
            debugPrint("UIBarButton Item setting target failed")
        }
    }
}
extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize=CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: self.backgroundColor ?? UIColor.clear), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: self.backgroundColor ?? UIColor.clear), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear ), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect  = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}


extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    var stringByJoiningHttpParameters: String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String)
            let percentEscapedValue = (value as! String)
            
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        return parameterArray.joined(separator: "&")
    }
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String)  .addingPercentEncoding(withAllowedCharacters:.controlCharacters)!
            let percentEscapedValue = (value as! String).addingPercentEncoding(withAllowedCharacters:.controlCharacters)!
            
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        return parameterArray.joined(separator: "&")
    }
}

extension Date {
    
    func format(formatString:String)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter.string(from:self)
    }
    
    var zeroHour:Date {
        let gregorian = Calendar(identifier: .gregorian)
        
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        
        return gregorian.date(from: components)!
    }
    var oneHour:Date {
        let gregorian = Calendar(identifier: .gregorian)
        
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 1
        components.minute = 0
        components.second = 0
        
        
        return gregorian.date(from: components)!
    }
    
}

extension Data {
    var hexString:String {
        return map { String(format: "%02x", $0) }.joined()
    }
}

extension UIDevice {
    var isSimulator: Bool {
        #if arch(i386) || arch(x86_64)
        return true
        #else
        return false
        #endif
    }
}

extension String
{
    
    var time:Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
    
    
    
    var theDateTime:Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "YYYY-MM-dd'T'HH:mm:ss.SSS" // "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "T00:00:00") //Current time zone
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat =  "YYYY-MM-dd'T'HH:mm:ss"// "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "T00:00:00") //Current time zone
        let date = dateFormatter.date(from: self) ?? (dateFormatter2.date(from: self) ?? Date())  //according to date format your date string
        return date
    }
    
    
    
    
    
    var theDateTimeShort:Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "T00:00:00") //Current time zone
        let date = dateFormatter.date(from: self) //according to date format your date string
        return date
    }
    
    var theDateWithDash:Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "T00:00:00") //Current time zone
        let date = dateFormatter.date(from: self) //according to date format your date string
        return date
    }
    
    var theDateTimeWithForwardSlash:Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "T00:00:00") //Current time zone
        let date = dateFormatter.date(from: self) //according to date format your date string
        return date
    }
    
    var theDateTimeFormalString:String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" //Your date format
        //dateFormatter.timeZone = TimeZone(abbreviation: "T00:00:00") //Current time zone
        let date = dateFormatter.date(from: self) //according to date format your date string
        return date?.format(formatString: "yyyy/MM/dd, HH:mm a") //2017 / 12 / 31, 9:30 pm
    }
    
    
    
    
    var localized:String {
        return NSLocalizedString(self, comment: "")
    }
    
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    //    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
    //        var result: [Range<Index>] = []
    //        var start = startIndex
    //        while let range = range(of: string, options: options, range: start..<endIndex) {
    //            result.append(range)
    //            start = range.upperBound
    //        }
    //        return result
    //    }
    var isResourceFile:Bool {
        if let bundlePath = self.bundlePath("") {
            return FileManager.default.fileExists(atPath: bundlePath)
        }
        return false
    }
    var httpPart:String? {
        return self.components(separatedBy: "?").first
    }
    func bundlePath(_ ext:String) -> String? {
        return Bundle.main.path(forResource: self, ofType: ext)
        
    }
    func bundleURL(_ ext:String) -> URL? {
        return URL(string:Bundle.main.path(forResource: self, ofType: ext) ?? "" )
    }
    var date:Date {
        let theDateString = self
        let dateFormatter = DateFormatter()
        if theDateString.contains("/") && theDateString.contains("T") {
            dateFormatter.dateFormat = "yyyy/MM/dd"
        }else if theDateString.contains("-")  && theDateString.contains("T"){
            dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS"
        }
        else if theDateString.contains("/")  {
            dateFormatter.dateFormat = "yyyy/MM/dd"
        }else if theDateString.contains("-")   {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        let date = dateFormatter.date(from:theDateString)  ?? Date()
        
        return date
    }
    
    var value: CGFloat? {
        return  self != "" ? CGFloat((Float(  self ) ?? 0 )!) : nil
    }
    var cgvalue: CGFloat {
        return  CGFloat( Float(  self) ?? 0 )
    }
    func relativeValue(for refValue:CGFloat)-> CGFloat? {
        return   self != "" ? refValue  * self.value! : nil
    }
    
    func bundlePath(withExtension:String) -> String? {
        return Bundle.main.path(forResource: self, ofType: withExtension)
    }
    var arrySplitByComma:[String] {
        return self.components(separatedBy: ",")
    }
    
    func decodeSingleQuote()->String {
        return self.replacingOccurrences(of: "'", with: "\"")
    }
    
    var percentHTMLEncoded:String {
        return self.addingPercentEncoding(withAllowedCharacters:.controlCharacters)!
    }
    
    var percentHTMLDecoded:String? {
        let entities = [
            // XML predefined entities:
            "&quot;"     : "\"",
            "&amp;"      : "&",
            "&apos;"     : "'",
            "&lt;"       : "<",
            "&gt;"       : ">",
            // HTML character entity references:
            "&nbsp;"     : "\u{00A0}",
            "&iexcl;"    : "\u{00A1}",
            "&cent;"     : "\u{00A2}",
            "&pound;"    : "\u{00A3}",
            "&curren;"   : "\u{00A4}",
            "&yen;"      : "\u{00A5}",
            "&brvbar;"   : "\u{00A6}",
            "&sect;"     : "\u{00A7}",
            "&uml;"      : "\u{00A8}",
            "&copy;"     : "\u{00A9}",
            "&ordf;"     : "\u{00AA}",
            "&laquo;"    : "\u{00AB}",
            "&not;"      : "\u{00AC}",
            "&shy;"      : "\u{00AD}",
            "&reg;"      : "\u{00AE}",
            "&macr;"     : "\u{00AF}",
            "&deg;"      : "\u{00B0}",
            "&plusmn;"   : "\u{00B1}",
            "&sup2;"     : "\u{00B2}",
            "&sup3;"     : "\u{00B3}",
            "&acute;"    : "\u{00B4}",
            "&micro;"    : "\u{00B5}",
            "&para;"     : "\u{00B6}",
            "&middot;"   : "\u{00B7}",
            "&cedil;"    : "\u{00B8}",
            "&sup1;"     : "\u{00B9}",
            "&ordm;"     : "\u{00BA}",
            "&raquo;"    : "\u{00BB}",
            "&frac14;"   : "\u{00BC}",
            "&frac12;"   : "\u{00BD}",
            "&frac34;"   : "\u{00BE}",
            "&iquest;"   : "\u{00BF}",
            "&Agrave;"   : "\u{00C0}",
            "&Aacute;"   : "\u{00C1}",
            "&Acirc;"    : "\u{00C2}",
            "&Atilde;"   : "\u{00C3}",
            "&Auml;"     : "\u{00C4}",
            "&Aring;"    : "\u{00C5}",
            "&AElig;"    : "\u{00C6}",
            "&Ccedil;"   : "\u{00C7}",
            "&Egrave;"   : "\u{00C8}",
            "&Eacute;"   : "\u{00C9}",
            "&Ecirc;"    : "\u{00CA}",
            "&Euml;"     : "\u{00CB}",
            "&Igrave;"   : "\u{00CC}",
            "&Iacute;"   : "\u{00CD}",
            "&Icirc;"    : "\u{00CE}",
            "&Iuml;"     : "\u{00CF}",
            "&ETH;"      : "\u{00D0}",
            "&Ntilde;"   : "\u{00D1}",
            "&Ograve;"   : "\u{00D2}",
            "&Oacute;"   : "\u{00D3}",
            "&Ocirc;"    : "\u{00D4}",
            "&Otilde;"   : "\u{00D5}",
            "&Ouml;"     : "\u{00D6}",
            "&times;"    : "\u{00D7}",
            "&Oslash;"   : "\u{00D8}",
            "&Ugrave;"   : "\u{00D9}",
            "&Uacute;"   : "\u{00DA}",
            "&Ucirc;"    : "\u{00DB}",
            "&Uuml;"     : "\u{00DC}",
            "&Yacute;"   : "\u{00DD}",
            "&THORN;"    : "\u{00DE}",
            "&szlig;"    : "\u{00DF}",
            "&agrave;"   : "\u{00E0}",
            "&aacute;"   : "\u{00E1}",
            "&acirc;"    : "\u{00E2}",
            "&atilde;"   : "\u{00E3}",
            "&auml;"     : "\u{00E4}",
            "&aring;"    : "\u{00E5}",
            "&aelig;"    : "\u{00E6}",
            "&ccedil;"   : "\u{00E7}",
            "&egrave;"   : "\u{00E8}",
            "&eacute;"   : "\u{00E9}",
            "&ecirc;"    : "\u{00EA}",
            "&euml;"     : "\u{00EB}",
            "&igrave;"   : "\u{00EC}",
            "&iacute;"   : "\u{00ED}",
            "&icirc;"    : "\u{00EE}",
            "&iuml;"     : "\u{00EF}",
            "&eth;"      : "\u{00F0}",
            "&ntilde;"   : "\u{00F1}",
            "&ograve;"   : "\u{00F2}",
            "&oacute;"   : "\u{00F3}",
            "&ocirc;"    : "\u{00F4}",
            "&otilde;"   : "\u{00F5}",
            "&ouml;"     : "\u{00F6}",
            "&divide;"   : "\u{00F7}",
            "&oslash;"   : "\u{00F8}",
            "&ugrave;"   : "\u{00F9}",
            "&uacute;"   : "\u{00FA}",
            "&ucirc;"    : "\u{00FB}",
            "&uuml;"     : "\u{00FC}",
            "&yacute;"   : "\u{00FD}",
            "&thorn;"    : "\u{00FE}",
            "&yuml;"     : "\u{00FF}",
            "&OElig;"    : "\u{0152}",
            "&oelig;"    : "\u{0153}",
            "&Scaron;"   : "\u{0160}",
            "&scaron;"   : "\u{0161}",
            "&Yuml;"     : "\u{0178}",
            "&fnof;"     : "\u{0192}",
            "&circ;"     : "\u{02C6}",
            "&tilde;"    : "\u{02DC}",
            "&Alpha;"    : "\u{0391}",
            "&Beta;"     : "\u{0392}",
            "&Gamma;"    : "\u{0393}",
            "&Delta;"    : "\u{0394}",
            "&Epsilon;"  : "\u{0395}",
            "&Zeta;"     : "\u{0396}",
            "&Eta;"      : "\u{0397}",
            "&Theta;"    : "\u{0398}",
            "&Iota;"     : "\u{0399}",
            "&Kappa;"    : "\u{039A}",
            "&Lambda;"   : "\u{039B}",
            "&Mu;"       : "\u{039C}",
            "&Nu;"       : "\u{039D}",
            "&Xi;"       : "\u{039E}",
            "&Omicron;"  : "\u{039F}",
            "&Pi;"       : "\u{03A0}",
            "&Rho;"      : "\u{03A1}",
            "&Sigma;"    : "\u{03A3}",
            "&Tau;"      : "\u{03A4}",
            "&Upsilon;"  : "\u{03A5}",
            "&Phi;"      : "\u{03A6}",
            "&Chi;"      : "\u{03A7}",
            "&Psi;"      : "\u{03A8}",
            "&Omega;"    : "\u{03A9}",
            "&alpha;"    : "\u{03B1}",
            "&beta;"     : "\u{03B2}",
            "&gamma;"    : "\u{03B3}",
            "&delta;"    : "\u{03B4}",
            "&epsilon;"  : "\u{03B5}",
            "&zeta;"     : "\u{03B6}",
            "&eta;"      : "\u{03B7}",
            "&theta;"    : "\u{03B8}",
            "&iota;"     : "\u{03B9}",
            "&kappa;"    : "\u{03BA}",
            "&lambda;"   : "\u{03BB}",
            "&mu;"       : "\u{03BC}",
            "&nu;"       : "\u{03BD}",
            "&xi;"       : "\u{03BE}",
            "&omicron;"  : "\u{03BF}",
            "&pi;"       : "\u{03C0}",
            "&rho;"      : "\u{03C1}",
            "&sigmaf;"   : "\u{03C2}",
            "&sigma;"    : "\u{03C3}",
            "&tau;"      : "\u{03C4}",
            "&upsilon;"  : "\u{03C5}",
            "&phi;"      : "\u{03C6}",
            "&chi;"      : "\u{03C7}",
            "&psi;"      : "\u{03C8}",
            "&omega;"    : "\u{03C9}",
            "&thetasym;" : "\u{03D1}",
            "&upsih;"    : "\u{03D2}",
            "&piv;"      : "\u{03D6}",
            "&ensp;"     : "\u{2002}",
            "&emsp;"     : "\u{2003}",
            "&thinsp;"   : "\u{2009}",
            "&zwnj;"     : "\u{200C}",
            "&zwj;"      : "\u{200D}",
            "&lrm;"      : "\u{200E}",
            "&rlm;"      : "\u{200F}",
            "&ndash;"    : "\u{2013}",
            "&mdash;"    : "\u{2014}",
            "&lsquo;"    : "\u{2018}",
            "&rsquo;"    : "\u{2019}",
            "&sbquo;"    : "\u{201A}",
            "&ldquo;"    : "\u{201C}",
            "&rdquo;"    : "\u{201D}",
            "&bdquo;"    : "\u{201E}",
            "&dagger;"   : "\u{2020}",
            "&Dagger;"   : "\u{2021}",
            "&bull;"     : "\u{2022}",
            "&hellip;"   : "\u{2026}",
            "&permil;"   : "\u{2030}",
            "&prime;"    : "\u{2032}",
            "&Prime;"    : "\u{2033}",
            "&lsaquo;"   : "\u{2039}",
            "&rsaquo;"   : "\u{203A}",
            "&oline;"    : "\u{203E}",
            "&frasl;"    : "\u{2044}",
            "&euro;"     : "\u{20AC}",
            "&image;"    : "\u{2111}",
            "&weierp;"   : "\u{2118}",
            "&real;"     : "\u{211C}",
            "&trade;"    : "\u{2122}",
            "&alefsym;"  : "\u{2135}",
            "&larr;"     : "\u{2190}",
            "&uarr;"     : "\u{2191}",
            "&rarr;"     : "\u{2192}",
            "&darr;"     : "\u{2193}",
            "&harr;"     : "\u{2194}",
            "&crarr;"    : "\u{21B5}",
            "&lArr;"     : "\u{21D0}",
            "&uArr;"     : "\u{21D1}",
            "&rArr;"     : "\u{21D2}",
            "&dArr;"     : "\u{21D3}",
            "&hArr;"     : "\u{21D4}",
            "&forall;"   : "\u{2200}",
            "&part;"     : "\u{2202}",
            "&exist;"    : "\u{2203}",
            "&empty;"    : "\u{2205}",
            "&nabla;"    : "\u{2207}",
            "&isin;"     : "\u{2208}",
            "&notin;"    : "\u{2209}",
            "&ni;"       : "\u{220B}",
            "&prod;"     : "\u{220F}",
            "&sum;"      : "\u{2211}",
            "&minus;"    : "\u{2212}",
            "&lowast;"   : "\u{2217}",
            "&radic;"    : "\u{221A}",
            "&prop;"     : "\u{221D}",
            "&infin;"    : "\u{221E}",
            "&ang;"      : "\u{2220}",
            "&and;"      : "\u{2227}",
            "&or;"       : "\u{2228}",
            "&cap;"      : "\u{2229}",
            "&cup;"      : "\u{222A}",
            "&int;"      : "\u{222B}",
            "&there4;"   : "\u{2234}",
            "&sim;"      : "\u{223C}",
            "&cong;"     : "\u{2245}",
            "&asymp;"    : "\u{2248}",
            "&ne;"       : "\u{2260}",
            "&equiv;"    : "\u{2261}",
            "&le;"       : "\u{2264}",
            "&ge;"       : "\u{2265}",
            "&sub;"      : "\u{2282}",
            "&sup;"      : "\u{2283}",
            "&nsub;"     : "\u{2284}",
            "&sube;"     : "\u{2286}",
            "&supe;"     : "\u{2287}",
            "&oplus;"    : "\u{2295}",
            "&otimes;"   : "\u{2297}",
            "&perp;"     : "\u{22A5}",
            "&sdot;"     : "\u{22C5}",
            "&lceil;"    : "\u{2308}",
            "&rceil;"    : "\u{2309}",
            "&lfloor;"   : "\u{230A}",
            "&rfloor;"   : "\u{230B}",
            "&lang;"     : "\u{2329}",
            "&rang;"     : "\u{232A}",
            "&loz;"      : "\u{25CA}",
            "&spades;"   : "\u{2660}",
            "&clubs;"    : "\u{2663}",
            "&hearts;"   : "\u{2665}",
            "&diams;"    : "\u{2666}",
            "+" : " ",
            ]
        
        
        let  removedPercentEncoding = self.removingPercentEncoding ?? ""
        var newStr = removedPercentEncoding
        for (name,value) in entities {
            newStr = newStr.replacingOccurrences(of: name, with: value)
        }
        return newStr
    }
    
    var statement:(condition:String?,type:String?) {
        
        let condition = self.components(separatedBy: "^").first
        let type = self.components(separatedBy: "^").last
        
        return (condition:condition,type:type)
        
    }
    
    var isBackSpace:Bool {
        let  char = self.cString(using: String.Encoding.utf8)!
        return   strcmp(char, "\\b") == -92
    }
    var isHtmlFile:Bool{
        return (self == "text/html")
    }
    var isDownloadableFile:Bool {
        let fileExts:Set<String> = ["application/pdf","application/vnd.ms-excel","text/csv","image/jpeg","image/png","application/vnd.ms-powerpoint" ,"text/html","video/mpeg","application/x-rar-compressed","application/rtf","application/zip"]
        return fileExts.contains(self)
    }
    
    var integer:Int? {
        return Int(self)
    }
}

extension Double {
    
    var toRadians: Double { return  self * .pi / 180 }
    var toDegrees: Double { return self * 180 / .pi }
}

extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    var isWithinParentView:Bool {
        
        if let parentView = self.superview {
            return parentView.frame.contains( parentView.convert(self.frame, to: parentView.superview))
        }
        return true
    }
    
    func setTopConstraint (_ value:CGFloat) {
        for constrain in self.constraints { //Show the component
            //TODO remove it hide to super
            if   constrain.firstAttribute == .top   { // ||  constrain.firstAttribute == .top ||  constrain.firstAttribute == .bottom {
                
                constrain.constant =  value
                break;
                
            }
        }
    }
    
    func removeHeightConstrain(  ) {
        
        for constrain in self.constraints {
            
            if   constrain.firstAttribute == .height {
                constrain.isActive = false
                self.removeConstraint(constrain)
                break
            }
            
            
        }
    }
    
    
    func setBottomConstraint (_ value:CGFloat, toView:UIView?  = nil ) {
        
        if     self.superview != nil ||  toView != nil  {
            
            
            //self.backgroundColor = UIColor.red
            NSLayoutConstraint(item: self, attribute: .bottom , relatedBy: .equal, toItem: toView ?? self.superview!     , attribute:  toView != nil ? .top : .bottom, multiplier: 1, constant: value).isActive = true
            self.removeHeightConstrain()
            self.updateConstraintsIfNeeded()
        }
    }
    
    
    func addConstrainToView(childView:UIView, withPadding: [CGFloat] = [0,0,0,0] )
    {
        
        
        NSLayoutConstraint(item: childView, attribute: .leading , relatedBy: .equal, toItem: self , attribute:  .leading, multiplier: 1, constant:   withPadding[3] ).isActive = true
        
        NSLayoutConstraint(item: childView, attribute: .top , relatedBy: .equal, toItem: self , attribute:  .top, multiplier: 1, constant:  withPadding[0] ).isActive = true
        
        NSLayoutConstraint(item: childView, attribute: .trailing , relatedBy: .equal, toItem: self , attribute:  .trailing, multiplier: 1, constant: -withPadding[1]  ).isActive = true
        
        NSLayoutConstraint(item: childView, attribute: .bottom , relatedBy: .equal, toItem: self , attribute:  .bottom, multiplier: 1, constant: -withPadding[3] ).isActive = true
        
        self.layoutIfNeeded()
        childView.layoutIfNeeded()
        
    }
    func addEqualWidthConstrainToView(childView:UIView)
    {
        
        
        NSLayoutConstraint(item: childView, attribute: .width   , relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: self.frame.size.width).isActive = true
        
        self.layoutIfNeeded()
        childView.layoutIfNeeded()
    }
    
    func addCenterVerticalConstrain(childView:UIView)
    {
        
        
        NSLayoutConstraint(item: childView, attribute: .centerY   , relatedBy: .equal, toItem: self , attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        self.layoutIfNeeded()
        childView.layoutIfNeeded()
    }
    
    
    func addBottomEqualConstrainToView(childView:UIView)
    {
        
        
        NSLayoutConstraint(item: childView, attribute: .bottom   , relatedBy: .equal, toItem: self , attribute: .bottom , multiplier: 1, constant: 0).isActive = true
        
        self.layoutIfNeeded()
        childView.layoutIfNeeded()
    }
    
    
    func setWidthConstrain(_ width:CGFloat ) {
        
        self.frame.size.width = width
        var found = false
        for constrain in self.constraints {
            
            if   constrain.firstAttribute == .width {
                constrain.constant = width
                found = true
                break
            }
            
            
        }
        
        if found == false {
            NSLayoutConstraint(item: self, attribute: .width   , relatedBy: .equal, toItem: nil , attribute: .notAnAttribute , multiplier: 1, constant: width).isActive = true
        }
    }
    
    func setLeadingConstrain(_ width:CGFloat ) {
        
        
        for constrain in self.constraints {
            
            if   constrain.firstAttribute == .leading {
                constrain.constant = width
                break
            }
            
            
        }
    }
    
    func restoreHeightConstrain() {
        var found = false
        for constrain in self.constraints {
            
            if   constrain.firstAttribute == .height && constrain.accessibilityValue != nil {
                constrain.constant = CGFloat( Float(constrain.accessibilityValue!) ?? 0 ?? 0)
                
                
                break
            }
            
            
        }
        
        
    }
    
    func disableAllHeightConstrains() {
        for constrain in self.constraints {
            
            if   constrain.firstAttribute == .height {
                constrain.isActive = false
                
            }
            
            
        }
    }
    
    func setHeightConstrain(_ height:CGFloat ) -> NSLayoutConstraint? {
        var found = false
        for constrain in self.constraints {
            
            if   constrain.firstAttribute == .height {
                constrain.constant = height
                constrain.accessibilityValue = String.init( describing: constrain.constant )
                found = true
                return constrain
                break
            }
            
            
        }
        
        if found == false {
            let constraint = NSLayoutConstraint(item: self, attribute: .height   , relatedBy: .equal, toItem: nil , attribute: .notAnAttribute , multiplier: 1, constant: height)
            constraint.isActive = true
            return constraint
        }
        self.layoutIfNeeded()
    }
    
    func addEqualHeightConstrainToView(childView:UIView)
    {
        
        
        NSLayoutConstraint(item: childView, attribute: .height   , relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: self.frame.size.height).isActive = true
        
        self.layoutIfNeeded()
        childView.layoutIfNeeded()
    }
    
    func addLeftTopRightConstraingWithHeightToView(childView:UIView, height:CGFloat)
    {
        
        NSLayoutConstraint(item: childView, attribute: .leading , relatedBy: .equal, toItem: self , attribute:  .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: childView, attribute: .top , relatedBy: .equal, toItem: self , attribute:  .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: childView, attribute: .trailing , relatedBy: .equal, toItem: self , attribute:  .trailing, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: childView, attribute: .height   , relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: height).isActive = true
        self.layoutIfNeeded()
        childView.layoutIfNeeded()
        
        
    }
    
    func addLeftBottomRightConstrainWithHeightToView(childView:UIView, height:CGFloat, padding:[CGFloat]  = [0,0,0,0]    )
    {
        
        NSLayoutConstraint(item: childView, attribute: .leading , relatedBy: .equal, toItem: self , attribute:  .leading, multiplier: 1, constant: padding[3]).isActive = true
        
        NSLayoutConstraint(item: childView, attribute: .bottom , relatedBy: .equal, toItem: self , attribute:  .bottom, multiplier: 1, constant: -padding[2]).isActive = true
        
        NSLayoutConstraint(item: childView, attribute: .trailing , relatedBy: .equal, toItem: self , attribute:  .trailing, multiplier: 1, constant:-padding[1]).isActive = true
        
        NSLayoutConstraint(item: childView, attribute: .height   , relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: height).isActive = true
        self.layoutIfNeeded()
        childView.layoutIfNeeded()
    }
    
    func dropShadow(scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 3.0
        self.layer.shadowOpacity = 0.7
        layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: -1, height: -1)
        
        self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
    }
}

extension UIViewController  {
    
    var backButtonColor:UIColor {
        set {
            
            //self.navigationController?.presentTransparentNavigationBar()
            self.navigationController?.navigationBar.tintColor = newValue
        }
        get {
            return self.navigationController?.navigationBar.tintColor ?? UIColor.blue
        }
    }
    
    func showActionSheet( options:[String],titleString:String? = nil, messageString:String? = nil,callBack:@escaping (_ selectedIndex:String)->()) {
        let actionSheetCtrl = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Cancel".localized, style: .cancel, handler:nil)
        actionSheetCtrl.addAction(action)
        
        for option in options {
            let action = UIAlertAction(title: option, style: .default, handler: { (action) in
                callBack(action.title ?? "")
            })
            actionSheetCtrl.addAction(action)
        }
        
        self.present(actionSheetCtrl, animated: true, completion: nil)
    }
    
    var showBusy:Bool {
        
        set {
            if newValue == true {
                //Freeze all
                self.view.isUserInteractionEnabled = false
                self.navigationController?.tabBarController?.tabBar.isUserInteractionEnabled = false
                //self.navigationController?.navigationBar.isUserInteractionEnabled = false
                var activityIndicatorView:NVActivityIndicatorView?
                for subView in self.view.subviews {
                    if subView is NVActivityIndicatorView {
                        activityIndicatorView = subView as? NVActivityIndicatorView
                        break
                    }
                }
                //First time create
                if activityIndicatorView == nil {
                    activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x:0, y:0, width:100, height:100))
                    self.view.addSubview(activityIndicatorView!)
                    activityIndicatorView!.center = self.view.center
                    activityIndicatorView?.padding = 10
                    activityIndicatorView?.type = .ballScaleMultiple
                    activityIndicatorView?.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
                    activityIndicatorView?.layer.cornerRadius = 7.0
                    //activityIndicatorView?.activityIndicatorViewStyle = .gray
                    activityIndicatorView?.frame.size = activityIndicatorView!.intrinsicContentSize
                } //No Activityindicator and try to set false, then return
                else if activityIndicatorView == nil &&  newValue == false {
                    return
                }
                if newValue == true {
                    activityIndicatorView?.startAnimating()
                }
                self.view.bringSubview(toFront: activityIndicatorView!)
                activityIndicatorView?.isHidden = !newValue
            }else {
                var activityIndicatorView:NVActivityIndicatorView?
                self.view.isUserInteractionEnabled = true
                self.navigationController?.tabBarController?.tabBar.isUserInteractionEnabled = true
                self.navigationController?.navigationBar.isUserInteractionEnabled = true
                for subView in self.view.subviews {
                    if subView is NVActivityIndicatorView {
                        activityIndicatorView = subView as? NVActivityIndicatorView
                        activityIndicatorView?.stopAnimating()
                        break
                    }
                }
            }
        }
        get {
            return false
        }
    }
    
    var titleColor :UIColor {
        set {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: newValue]
        }
        get {
            return self.navigationController?.navigationBar.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor ?? UIColor.black
        }
    }
    
    func alert(title:String, message:String, actionStrings:[String]? = [ "Ok".localized], completion:((UIAlertAction)->())? = nil )
    {
        let alertCtrl =  UIAlertController(title:title, message: message,preferredStyle: .alert)
        for actionString in actionStrings! {
            let alertActionOK = UIAlertAction(title:actionString ,style: .default, handler:  completion)
            //Add OK Button
            alertCtrl.addAction(alertActionOK)
        }
        //Then Show
        present(alertCtrl, animated: true, completion: nil)
    }
    
    func addUserPhotoToTheView(imageURL:URL?)
    {
        if let photourl = imageURL ,self.view != nil        {
            DispatchQueue.global().async {
                
                
                let url =   photourl
                let task =  URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    
                    if error == nil && data != nil
                    {
                        let image = UIImage(data: data!)
                        DispatchQueue.main.async {
                            let imageView = UIImageView()
                            imageView.frame.size = CGSize(width: 50, height: 50)
                            imageView.center = self.view.center
                            imageView.layer.cornerRadius = 25
                            imageView.clipsToBounds  = true
                            imageView.contentMode = .scaleAspectFill
                            imageView.image = image
                            imageView.alpha = 0.0
                            self.view.addSubview(  imageView)
                            
                            UIView.animate(withDuration: 0.4, delay:1.0, options: .curveEaseIn, animations: {
                                imageView.alpha = 1.0
                            }, completion: nil)
                        }
                    }
                })
                
                task.resume()
                
            }
        }
    }
    
    
    
}



func videoSnapshot(filePathLocal: String) -> UIImage? {
    
    let vidURL = URL(fileURLWithPath:filePathLocal as String)
    let asset = AVURLAsset(url: vidURL)
    let generator = AVAssetImageGenerator(asset: asset)
    generator.appliesPreferredTrackTransform = true
    
    let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
    
    do {
        let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
        return UIImage(cgImage: imageRef)
    }
    catch let error as NSError
    {
        debugPrint("Image generation failed with error \(error)")
        return nil
    }
}

extension  UIImagePickerController {
    
    func setupForUserLibrary( ) {
        self.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.sourceType)!
        self.allowsEditing = true
    }
    
    func setupForCamera( ) {
        self.sourceType = UIImagePickerControllerSourceType.camera
        self.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.sourceType)!
        self.allowsEditing = true
    }
}
extension UINavigationBar {
    
    func makeTransparent() {
        
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
    func makeWhite() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}


//extension LineChartDataSet {
//    func setupCommonLineChartData() {
//        self.valueFont = .systemFont(ofSize: 10)
//        self.drawValuesEnabled = false//true
//        self.mode = .linear
//        self.circleRadius = 5
//        self.lineWidth = 2.5
//        self.circleHoleRadius = 2.5
//        self.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
//    }
//    func setupForUserWeightDataLineChart () {
//        setupCommonLineChartData()
//        self.setColor(UIColor(red: 31/255, green: 186/255, blue: 252/255, alpha: 1))
//        self.setCircleColor(UIColor(red: 31/255, green: 186/255, blue: 252/255, alpha: 1))
//        self.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
//        self.axisDependency = .left
//    }
//    
//    func setupForNutrientDataLineChart () {
//        setupCommonLineChartData()
//        self.setColor(UIColor(red: 150/255, green: 76/255, blue: 219/255, alpha: 1))
//        self.setCircleColor(UIColor(red: 150/255, green: 76/255, blue: 219/255, alpha: 1))
//        self.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
//        self.axisDependency = .left
//    }
//    
//    func setupForUserBodyFatDataLineChart() {
//        setupCommonLineChartData()
//        self.setColor(UIColor(red: 248/255, green: 140/255, blue: 5/255, alpha: 1))
//        self.setCircleColor(UIColor(red: 245/255, green: 140/255, blue: 5/255, alpha: 1))
//        self.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
//        self.axisDependency = .right
//    }
//    
//    func setupForUserTargetWeightDataLineChart() {
//        setupCommonLineChartData()
//        self.setColor(UIColor(red: 255/255, green: 94/255, blue: 66/255, alpha: 1))
//        self.setCircleColor(UIColor(red: 255/255, green: 94/255, blue: 66/255, alpha: 1))
//        self.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
//        self.axisDependency = .left
//    }
//    
//    
//    func setupForUpperBPDataLineChart () {
//        setupCommonLineChartData()
//        self.setColor(UIColor(red: 34/255, green: 180/255, blue: 176/255, alpha: 1))
//        self.setCircleColor(UIColor(red: 34/255, green: 180/255, blue: 176/255, alpha: 1))
//        self.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
//        self.axisDependency = .left
//    }
//    func setupForLowerBPDataLineChart () {
//        setupCommonLineChartData()
//        self.setColor(UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1))
//        self.setCircleColor(UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1))
//        self.fillColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
//        self.axisDependency = .left
//    }
//    
//    func setupForBloodPressureDataLineChart () {
//        setupCommonLineChartData()
//        self.setColor(UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1))
//        self.setCircleColor(UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1))
//        self.fillColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        self.axisDependency = .left
//        self.valueTextColor =  UIColor.gray
//    }
//    
//}


class CustomError: NSObject, LocalizedError {
    var customDescription = ""
    init(str: String) {
        customDescription = str
    }
    override var description: String {
        get {
            return customDescription
        }
    }
    //need to implement `errorDescription`, not `localizedDescription`.
    var errorDescription: String? {
        get {
            return self.description
        }
    }
}


