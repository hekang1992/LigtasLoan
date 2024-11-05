//
//  LLLastInfo.swift
//  LigtasLoan
//
//  Created by LigtasLoan on 2024/11/4.
//

import SystemServices

class LLSBFourDict {
    
    static func fourinfo() -> [String: Any] {
        let currentIPAddress = SSNetworkInfo.currentIPAddress() ?? ""
        let appInfo = LLSBTwoDict.getAppssnfo()
        let macAddress = LLSBTwoDict.getMac()
        
        return [
            "four": ["four": "4"],
            "warship": [
                "tanneries": currentIPAddress,
                "foundries": [
                    "aquizzical": appInfo,
                    "mills": macAddress,
                    "shipyards": macAddress,
                    "woolen": appInfo
                ]
            ]
        ]
    }
}


class LLSBFiveDict {
    
    static func disk1() -> String {
        let freeDisk = String(format: "%.2lld", SystemServices.shared().longFreeDiskSpace)
        return freeDisk
    }
    
    static func disk2() -> String {
        let allDisk = String(format: "%.2lld", SystemServices.shared().longDiskSpace)
        return allDisk
    }
    
    static func disk3() -> String {
        let totalMemory = String(format: "%.0f", SystemServices.shared().totalMemory * 1024 * 1024)
        return totalMemory
    }
    
    static func disk4() -> String {
        let activeMemoryinRaw = String(format: "%.0f", SystemServices.shared().activeMemoryinRaw * 1024 * 1024)
        return activeMemoryinRaw
    }
    
    static func fiveInfo() -> [String: Any] {
        return [
            "five": "5",
            "themason": [
                "factory": disk1(),
                "cannon": disk2(),
                "outsider": disk3(),
                "thatsomehow": disk4()
            ]
        ]
    }
    
}

