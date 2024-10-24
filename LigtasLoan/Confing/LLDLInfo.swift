//
//  LLDLInfo.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/23.
//

import UIKit
import KeychainAccess

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
        
        let idfv = KeychainHelper.huoquidfv() ?? ""
        
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

class KeychainHelper {
    
    static func savein() {
        let cc = UIDevice.current
        guard let idfv = cc.identifierForVendor?.uuidString else {
            return
        }
        let keychain = Keychain(service: "com.LigtasLoan.Ph")
        do {
            try keychain.set(idfv, key: "deviceIDFV")
        } catch {
            print("Error: \(error)")
        }
    }
    
    static func huoquidfv() -> String? {
        let keychain = Keychain(service: "com.LigtasLoan.Ph")
        do {
            if let idfv = try keychain.get("deviceIDFV") {
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
}
