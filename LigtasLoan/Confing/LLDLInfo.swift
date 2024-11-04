//
//  LLDLInfo.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/23.
//

import UIKit
import KeychainAccess
import AdSupport
import SystemServices

let LL_LOGIN = "LL_LOGIN"
let LL_SESSIONID = "LL_SESSIONID"
let LL_MAI_DIAN_ONE = "LL_MAI_DIAN_ONE"

class LLDLInfo: NSObject {
    
    static func savedlInfo(_ phone: String, _ sessionID: String) {
        UserDefaults.standard.setValue(sessionID, forKey: LL_SESSIONID)
        UserDefaults.standard.setValue(phone, forKey: LL_LOGIN)
        UserDefaults.standard.setValue("", forKey: LL_MAI_DIAN_ONE)
        UserDefaults.standard.synchronize()
    }
    
    static func removedlInfo() {
        let keys = [LL_LOGIN, LL_SESSIONID, LL_MAI_DIAN_ONE]
        keys.forEach { UserDefaults.standard.setValue("", forKey: $0) }
        UserDefaults.standard.synchronize()
    }
    
    static func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    static func getLogiInfo() -> [String: String] {
        let screamed = UserDefaults.standard.string(forKey: LL_SESSIONID) ?? ""
        
        let duty = UIDevice.current.systemVersion
        
        let kitchen = UIDevice.current.name
        
        let idfv = SaveIdentityConfig.huoquidfv() ?? ""
        
        var logdict: [String: String] = ["meal": "ios",
                                         "inquiring": getAppVersion(),
                                         "warmed": "mmla",
                                         "kitchen": kitchen,
                                         "cheerless": idfv,
                                         "php": "peace"]
        
        let otherlInfo: [String: String] = ["code": "1",
                                            "language": "swift",
                                            "screamed": screamed,
                                            "duty": duty,
                                            "blazed": idfv,
                                            "boyfine": "1"]
        
        logdict.merge(otherlInfo) { (_, new) in new }
        
        return logdict
    }
    
}

class WLInfo: NSObject {
    
    static func isVPNCd() -> String {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [String: Any],
           let scopes = proxySettings["__SCOPED__"] as? [String: Any] {
            for key in scopes.keys {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") {
                    return "1"
                }
            }
        }
        return "0"
    }
    
}

class SaveIdentityConfig {
    
    static func savein() {
        let cc = UIDevice.current
        guard let idfv = cc.identifierForVendor?.uuidString else {
            return
        }
        let keychain = Keychain(service: "com.LigtasLoan.123")
        do {
            try keychain.set(idfv, key: "dfv.lig")
        } catch {
            print("Error: \(error)")
        }
    }
    
    static func huoquidfv() -> String? {
        let keychain = Keychain(service: "com.LigtasLoan.123")
        do {
            if let idfv = try keychain.get("dfv.lig") {
                return idfv
            } else {
                savein()
                return huoquidfv()
            }
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    static func getidfa() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
}

class LLSBOneDict {
    static func getLastTimeMillis() -> String {
        let uptime = ProcessInfo.processInfo.systemUptime
        let lastLoginDate = Date(timeIntervalSinceNow: -uptime)
        return String(format: "%ld", Int(lastLoginDate.timeIntervalSince1970 * 1000))
    }
    static func onesheinfo() -> [String: Any] {
        let batteryLevel = SystemServices().batteryLevel
        let batteryState = SystemServices().charging ? 1 : 0
        return [
            "unmistakable": UIDevice.current.systemVersion,
            "humming": getLastTimeMillis(),
            "crowdand": Bundle.main.bundleIdentifier ?? "",
            "disturbedbees": "iOS",
            "lo": "1",
            "murmuring": [
                "ominous": batteryLevel,
                "sleeve": batteryState
            ]
        ]
    }
}


class LLAllDict {
    static func sheAllnfo() -> [String: Any] {
        var dict: [String: Any] = ["all": "0"]
        let dict1 = LLSBOneDict.onesheinfo()
        let dict2 = LLSBTwoDict.twoinfoff()
        let dict3 = LLSBThreeDict.threeonfo()
        let dict4 = LLSBFourDict.fourinfo()
        let dict5 = LLSBFiveDict.fiveInfo()
        dict.merge(dict1) { (current, _) in current }
        dict.merge(dict2) { (current, _) in current }
        dict.merge(dict3) { (current, _) in current }
        dict.merge(dict4) { (current, _) in current }
        dict.merge(dict5) { (current, _) in current }
        return dict
    }
}
