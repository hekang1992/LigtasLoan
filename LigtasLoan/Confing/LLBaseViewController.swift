//
//  LLBaseViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/12.
//

import UIKit
import RxSwift

let schemeurl = "loan://app.ligtas.ios/"

class LLBaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

extension LLBaseViewController {
    
    func apply(from proid: String) {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["lo": proid, "knewdifferently": "1", "flirting": "love"], pageUrl: "/ll/tarletonwho/faces/straight", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success.andmammy == 0 || success.andmammy == 00 {
                    let nextUrl = success.preferreda.foryou ?? ""
                    if nextUrl.hasPrefix("http") {
                        
                    }else if nextUrl.hasPrefix(schemeurl) {
                        if let url = URL(string: nextUrl) {
                            let path = url.path
                            if path.contains("/mountainOnio") {
                                guard let query = url.query else { return }
                                let arrList = query.components(separatedBy: "=")
                                let lo = arrList.last ?? ""
                                proDetailInfo(from: lo)
                            }
                        }
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    @objc func proDetailInfo(from proid: String) {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["lo": proid, "sooddly": "1", "shoothim": "0"], pageUrl: "/ll/another/between/healthy", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success.andmammy == 0 || success.andmammy == 00 {
                    if let hisgold = success.preferreda.hisgold {
                        typeVc(form: hisgold.gabbling ?? "", proid: proid)
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func pageinDetailInfo(from proid: String) {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["lo": proid, "sooddly": "1", "shoothim": "0"], pageUrl: "/ll/another/between/healthy", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success.andmammy == 0 || success.andmammy == 00 {
                    if let hisgold = success.preferreda.hisgold {
                        if hisgold.gabbling == "eastern2" {
                            self.pageintypeVc(form: hisgold.gabbling ?? "", proid: proid)
                        }
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func pageintypeVc(form type: String, proid: String) {
        switch type {
        case "eastern1":
            let listVc = LLTypeListViewController()
            listVc.lo.accept(proid)
            self.navigationController?.pushViewController(listVc, animated: true)
            break
        case "eastern2":
            let listVc = LLStepTwoViewController()
            listVc.lo.accept(proid)
            self.navigationController?.pushViewController(listVc, animated: true)
            break
        case "eastern3":
            break
        case "eastern4":
            break
        case "eastern5":
            break
        default:
            break
        }
    }
    
    func typeVc(form type: String, proid: String) {
        let listVc = LLTypeListViewController()
        listVc.lo.accept(proid)
        self.navigationController?.pushViewController(listVc, animated: true)
    }
    
    func pushlistvc() {
        if let viewControllers = navigationController?.viewControllers {
            var found = false
            for vc in viewControllers {
                if vc is LLTypeListViewController {
                    navigationController?.popToViewController(vc, animated: true)
                    found = true
                    break
                }
            }
            if !found {
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
}
