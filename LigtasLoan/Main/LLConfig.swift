//
//  LLConfig.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit

let Bold_Poppins = "Poppins-Bold"
let Regular_Poppins = "Poppins-Regular"

let LL_SESSIONID = "LL_SESSIONID"

let ROOT_VC = "ROOT_VC"

var is_login: Bool {
    if let sessionID = UserDefaults.standard.object(forKey: LL_SESSIONID) as? String {
        return !sessionID.isEmpty
    } else {
        return false
    }
}

class StatusBarHelper {
    class func getStatusBarHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.statusBarManager?.statusBarFrame.height ?? 0
        }
        return 0
    }
}

extension UIColor {
    convenience init(cssStr: String) {
        var hexString: String = cssStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            self.init(white: 0.0, alpha: 0.0)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
