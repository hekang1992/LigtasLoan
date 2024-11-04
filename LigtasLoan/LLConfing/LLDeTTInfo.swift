//
//  LLDeTTInfo.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/11/4.
//

import DeviceKit

class LLSBThreeDict {
    
    static func screenDimensions() -> (width: String, height: String) {
        let width = String(format: "%.0f", sc_width)
        let height = String(format: "%.0f", sc_height)
        return (width, height)
    }
    
    static func threeonfo() -> [String: Any] {
        let deviceName = Device.current.name ?? ""
        let deviceDescription = Device.current.description
        let deviceSystemVersion = Device.current.systemVersion ?? ""
        let (width, height) = screenDimensions()
        
        return [
            "three": ["three": "3"],
            "speaker": [
                "besidethe": "1",
                "stick": deviceName,
                "werebeginning": "lo",
                "evidently": height,
                "bloodcoming": deviceName,
                "harbors": width,
                "bottle": deviceDescription,
                "fleet": String(Device.current.diagonal),
                "theyankee": deviceSystemVersion
            ]
        ]
    }
}
