//
//  LLLaunchViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/12.
//

import UIKit
import Alamofire
import Moya
import Network

class LLLaunchViewController: LLBaseViewController {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "LigtasLoanlaunch")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
        DispatchQueue.main.async {
            self.judugeNet()
        }
    }
    
}

extension LLLaunchViewController {
    
    private func judugeNet() {
        networkManager.startListening()
    }
    
}

class NetworkManager {
    static let shared = NetworkManager()
    private var reachabilityManager: NetworkReachabilityManager?

    private init() {
        reachabilityManager = NetworkReachabilityManager()
    }

    func startListening() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                print("Network not reachable")
            case .reachable(.ethernetOrWiFi):
                print("Network reachable via WiFi")
            case .reachable(.cellular):
                print("Network reachable via Cellular")
            case .unknown:
                print("Network status unknown")
            }
        })
    }
}
