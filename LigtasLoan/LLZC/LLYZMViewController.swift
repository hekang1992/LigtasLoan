//
//  LLYZMViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit
import RxRelay

class LLYZMViewController: LLBaseViewController {
    
    var phoneStr = BehaviorRelay<String>(value: "")
    
    var codeStr = BehaviorRelay<String>(value: "")
    
    var codeTime = 60
    
    var codeTimer: Timer!
    
    lazy var codeView: LLYZMView = {
        let codeView = LLYZMView()
        codeView.sImageView.isHidden = true
        codeView.mlabel.text = "Enter Verification Code"
        codeView.nlabel.text = "Enter your phone number, if not registered, it will be automatically registered."
        return codeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        codeView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
        codeView.securityCodeView.addTarget(self, action: #selector(unitFieldEditingChanged(_:)), for: .editingChanged)
        
        tapClick()
        yzmhuoqu(self.codeView.codeBtn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        codeView.securityCodeView.resignFirstResponder()
    }
    
}

extension LLYZMViewController: WLUnitFieldDelegate {
    
   @objc func unitFieldEditingChanged(_ sender: WLUnitField) {
        print("\(#function), \(sender.text ?? "")")
       if let textStr = sender.text, textStr.count > 0 {
           self.codeStr.accept(textStr)
           codeView.nextBtn.isEnabled = true
           codeView.nextBtn.setImage(UIImage(named: "keyiidanjibetn"), for: .normal)
       }else {
           codeView.nextBtn.isEnabled = false
           codeView.nextBtn.setImage(UIImage(named: "nextimagebbt"), for: .normal)
       }
    }
    
    private func tapClick() {
        codeView.codeBlock = { [weak self] btn in
            guard let self = self else { return }
            yzmhuoqu(btn)
        }
        codeView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            tologin()
        }).disposed(by: disposeBag)
    }
    
    private func yzmhuoqu(_ btn: UIButton) {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        let dict = ["precepts": "code", "revealed": phoneStr.value]
        man.requestAPI(params: dict, pageURL: "/ll/frequently/young/shoot", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(let success):
                ToastUtility.showToast(message: success.whey)
                btn.isEnabled = false
                codeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                break
            case .failure(_):
                break
            }
        }
    }
    
    private func tologin() {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        let dict = ["ofhurt": phoneStr.value,
                    "friendliness": codeStr.value,
                    "borders": "1"]
        man.requestAPI(params: dict, pageURL: "/ll/childhood/family/oversomething", method: .post) { result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                let model = success.preferreda
                LLDLInfo.savedlInfo(model.ofhurt ?? "", model.screamed ?? "")
                NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
                break
            case .failure(_):
                break
            }
        }
    }
    
    @objc func updateTime() {
        if codeTime > 0 {
            codeTime -= 1
            self.codeView.codeBtn.setTitle("(\(self.codeTime)s)", for: .normal)
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        codeTimer.invalidate()
        self.codeView.codeBtn.isEnabled = true
        self.codeView.codeBtn.setTitle("Resend", for: .normal)
        codeTime = 60
    }
    
}

