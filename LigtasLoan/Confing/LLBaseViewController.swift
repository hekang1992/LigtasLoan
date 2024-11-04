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
        man.requestAPI(params: ["lo": proid, "knewdifferently": "1", "flirting": "love"], pageURL: "/ll/tarletonwho/faces/straight", method: .post) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success.andmammy == 0 || success.andmammy == 00 {
                    let nextUrl = success.preferreda.foryou ?? ""
                    if nextUrl.hasPrefix("http") {
                        ViewLoadingManager.hideLoadingView()
                        let wv = LLWYViewController()
                        wv.pageUrl.accept(nextUrl)
                        self.navigationController?.pushViewController(wv, animated: true)
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
        let man = LLRequestManager()
        man.requestAPI(params: ["lo": proid, "sooddly": "1", "shoothim": "0"], pageURL: "/ll/another/between/healthy", method: .post) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success.andmammy == 0 || success.andmammy == 00 {
                    if let hisgold = success.preferreda.hisgold, let gabbling = hisgold.gabbling, !gabbling.isEmpty {
                        ViewLoadingManager.hideLoadingView()
                        typeVc(form: gabbling, proid: proid)
                    }else {
                        if let trembling = success.preferreda.consternation?.trembling {
                            self.ddtovc(from: trembling)
                        }
                    }
                }
                break
            case .failure(_):
                ViewLoadingManager.hideLoadingView()
                break
            }
        }
    }
    
    func pageinDetailInfo(from proid: String) {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["lo": proid, "sooddly": "1", "shoothim": "0"], pageURL: "/ll/another/between/healthy", method: .post) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success.andmammy == 0 || success.andmammy == 00 {
                    if let hisgold = success.preferreda.hisgold, let gabbling = hisgold.gabbling, !gabbling.isEmpty {
                        ViewLoadingManager.hideLoadingView()
                        if gabbling == "eastern2" {
                            self.pageintypeVc(form: gabbling, proid: proid)
                        }
                    }else {
                        if let trembling = success.preferreda.consternation?.trembling {
                            self.ddtovc(from: trembling)
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
            let listVc = LLStepTHRViewController()
            listVc.lo.accept(proid)
            self.navigationController?.pushViewController(listVc, animated: true)
            break
        case "eastern4":
            let listVc = LLStepTFViewController()
            listVc.lo.accept(proid)
            self.navigationController?.pushViewController(listVc, animated: true)
            break
        case "eastern5":
            let listVc = LLQAWViewController()
            listVc.lo.accept(proid)
            self.navigationController?.pushViewController(listVc, animated: true)
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
    
    func nextvc(form type: String, proid: String) {
        if type == "eastern1" {
            self.huoquid(from: proid)
        } else if type == "eastern2" {
            let ne = LLStepTwoViewController()
            ne.lo.accept(proid)
            self.navigationController?.pushViewController(ne, animated: true)
        } else if type == "eastern3" {
            let ne = LLStepTHRViewController()
            ne.lo.accept(proid)
            self.navigationController?.pushViewController(ne, animated: true)
        } else if type == "eastern4" {
            let ne = LLStepTFViewController()
            ne.lo.accept(proid)
            self.navigationController?.pushViewController(ne, animated: true)
        } else if type == "eastern5" {
            let ne = LLQAWViewController()
            ne.lo.accept(proid)
            self.navigationController?.pushViewController(ne, animated: true)
        } else if type == "eastern6" {
            pageinDetailInfo(from: proid)
        }
    }
    
    func huoquid(from proid: String) {
        let man = LLRequestManager()
        ViewLoadingManager.addLoadingView()
        man.requestAPI(params: ["lo": proid, "recallanything": "happy"], pageURL: "/ll/sitting/troop/affection", method: .get) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                let model = success.preferreda
                if let dully = model.toremember?.dully, let self = self {
                    if dully == 0 {
                        self.goIDvC(form: proid)
                    }else {
                        self.goca(form: proid)
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func goIDvC(form lo: String) {
        let vc = LLIDListViewController()
        vc.lo.accept(lo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goca(form lo: String) {
        let vc = LLUploadIDViewController()
        vc.lo.accept(lo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleStorySelection(_ model: widehallModel, cell: LLBtnClickCell) {
        let underthe = model.underthe ?? ""
        let hatred = model.hatred ?? ""
        switch underthe {
        case "story1":
            print("story1")
            if hatred.contains("Payday") {
                if let theirbeauty = model.theirbeauty {
                    let modelArray = TPopConfig.getTDetails(dataSourceArr: theirbeauty)
                    OneTwoThreePopConfig.popLastEnum(.city, cell.mlabel1, modelArray, model) {
                    }
                }
            }else {
                if let theirbeauty = model.theirbeauty {
                    let modelArray = OnePopConfig.getOneDetails(dataSourceArr: theirbeauty)
                    OneTwoThreePopConfig.popLastEnum(.province, cell.mlabel1, modelArray, model) {
                    }
                }
            }
        case "story2":
            print("story2")
        case "story3":
            print("story3")
            fetchStoryData(for: cell)
        case "story4":
            print("story4")
        default:
            break
        }
    }
    
    func fetchStoryData(for cell: LLBtnClickCell) {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["": ""], pageURL: "/ll/after/tomcat/foreverrankled", method: .get) { result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                if let unending = success.preferreda.unending, let model = cell.model.value {
                    let modelArray = SanPopConfig.SanChengArray(dataArr: unending)
                    OneTwoThreePopConfig.popLastEnum(.area, cell.mlabel1, modelArray, model) {
                    }
                }
            case .failure(let failure):
                print("\(failure.localizedDescription)")
            }
        }
    }
    
    func ddtovc(from oid: String) {
        let odDict = ["comforting": "1", "finally": oid, "twinge": "owo", "marriedindia": "lg-sa"]
        let man = LLRequestManager()
        man.requestAPI(params: odDict, pageURL: "/ll/wonderedif/thenher/these", method: .post) { result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                ViewLoadingManager.hideLoadingView()
                let nextUrl = success.preferreda.foryou ?? ""
                let wv = LLWYViewController()
                wv.pageUrl.accept(nextUrl)
                self.navigationController?.pushViewController(wv, animated: true)
                break
            case .failure(_):
                break
            }
        }
    }
    
}
