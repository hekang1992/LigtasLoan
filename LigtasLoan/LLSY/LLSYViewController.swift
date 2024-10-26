//
//  LLSYViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit
import GYSide
import RxRelay

class LLSYViewController: LLBaseViewController {
    
    lazy var oneView: OneView = {
        let oneView = OneView()
        oneView.isHidden = true
        return oneView
    }()
    
    lazy var twoView: TwoView = {
        let twoView = TwoView()
        twoView.isHidden = true
        return twoView
    }()
    
    var homeModel = BehaviorRelay<preferredaModel?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.addSubview(oneView)
        view.addSubview(twoView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        twoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oneView.rightBtn.rx
            .tap
            .subscribe(onNext: { [weak self] in
            self?.rightVc()
        }).disposed(by: disposeBag)
        
        oneView.ctImageView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.apply(from: self?.homeModel.value?.nothave?.aviolence?.first?.cad ?? "")
            }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeInfo()
    }
    
}

extension LLSYViewController {
    
    private func rightVc() {
        let vc = LLRightViewController()
        gy_showSide({ (config) in
            config.direction = .right
            config.animationType = .translationMask
        }, vc)
    }
    
    
    private func homeInfo() {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["home": "misdeeds", "ancestors": "purple"], pageUrl: "/ll/huntingsquire/enough/hishorses", method: .get) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                let model = success.preferreda
                self?.homeModel.accept(model)
                if model.nothave?.elemental == "apprehend2" {
                    self?.oneView.isHidden = false
                    self?.twoView.isHidden = true
                } else {
                    
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
}
