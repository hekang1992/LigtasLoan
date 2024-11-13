//
//  LLLaunchViewController.swift
//  LigtasLoan
//
//  Created by LigtasLoan on 2024/10/12.
//

import UIKit
import Alamofire
import Network
import AppTrackingTransparency
import KeychainAccess
import AdSupport

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
        self.judugeNet()
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
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .notReachable:
                print("Network not reachable")
            case .reachable(.ethernetOrWiFi):
                print("Network reachable via WiFi")
                self.locationInfo()
            case .reachable(.cellular):
                print("Network reachable via Cellular")
                self.locationInfo()
            case .unknown:
                print("Network status unknown")
            }
        })
        
    }
    
    private func locationInfo() {
        let location = LLLocationConfig()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        location.startUpdatingLocation { [weak self] model in
            print("model========:\(model.strongest)====\(dateFormatter.string(from: Date()))")
            self?.upgifno()
        }
    }
    
    public func upgifno() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .restricted:
                        break
                    case .authorized, .denied, .notDetermined:
                        self.upshine()
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
    }
    
    private func upshine() {
        let man = LLRequestManager()
        let dict = ["heavily": "0", "quarrel": SaveIdentityConfig.huoidfv() ?? "", "seldomthat": SaveIdentityConfig.getidfa()]
        man.requestAPI(params: dict, pageURL: "/ll/gambling/rounded/scarlett", method: .post) { result in
            
        }
    }
    
}
