//
//  LLDeInfo.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/11/4.
//

import SystemConfiguration.CaptiveNetwork
import DeviceKit
import SystemServices
import Alamofire

class LLSBTwoDict {
    
    static  func getAppssnfo() -> String {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            currentSSID = myDict["SSID"] as? String ?? ""
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    
    static func getMac() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return ""
        }
        for interface in interfaces {
            guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? else {
                continue
            }
            if let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String {
                return bssid
            }
        }
        return ""
    }
    
    static func getCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let currentTimeMillis = String(Int64(currentTime * 1000))
        return currentTimeMillis
    }
    
    static func is_Proxy() -> String {
        if let proxyUsgs = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any],
           let proxies = CFNetworkCopyProxiesForURL(URL(string: "https://www.apple.com")! as CFURL, proxyUsgs as CFDictionary).takeRetainedValue() as? [Any],
           let settings = proxies.first as? [AnyHashable: Any],
           let proxyType = settings[kCFProxyTypeKey] as? String {
            if proxyType == kCFProxyTypeNone as String {
                return "0"
            } else {
                return "1"
            }
        }
        return "0"
    }
    
    static func is_ected() -> Bool {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
    
    static func is_Break() -> String {
        let jailbreakToolPaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        for path in jailbreakToolPaths {
            if FileManager.default.fileExists(atPath: path) {
                return "1"
            }
        }
        return "0"
    }
    
    static func timeBoot() -> String {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        return String(format: "%.0f", systemUptime * 1000)
    }
    
    static func netxing() -> String {
        var wifoni: String = "none"
        let reachabilityManager = NetworkReachabilityManager()
        let status = reachabilityManager?.status
        if status == .notReachable {
            wifoni = "none"
        } else if status == .reachable(.ethernetOrWiFi) {
            wifoni = "wifi"
        } else if status == .reachable(.cellular) {
            wifoni = "5g/4g"
        }else {
            wifoni = "none"
        }
        return wifoni
    }
    
    static func twoinfoff() -> [String: Any] {
        var dict: [String: Any] = ["": ""]
        dict["two"] = ["two": "2"]
        dict["coalmines"] = [
            "quarrel": SaveIdentityConfig.huoquidfv() ?? "",
            "seldomthat": SaveIdentityConfig.getidfa(),
            "shipyards": getMac(),
            "factories": getCurrentTime(),
            "thousands": is_Proxy(),
            "seenmany": is_ected(),
            "presentknew": is_Break(),
            "is_simulator": Device.current.isSimulator ? "1" : "0",
            "fewyears": SystemServices().language ?? "",
            "believingthat": "php_cell_bb",
            "museums": netxing(),
            "guest": NSTimeZone.system.abbreviation() ?? "",
            "impress": timeBoot()
        ]
        return dict
    }
}


