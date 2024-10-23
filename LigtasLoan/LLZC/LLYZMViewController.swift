//
//  LLYZMViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit

class LLYZMViewController: LLBaseViewController {
    
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
           codeView.nextBtn.isEnabled = true
           codeView.nextBtn.setImage(UIImage(named: "keyiidanjibetn"), for: .normal)
       }else {
           codeView.nextBtn.isEnabled = false
           codeView.nextBtn.setImage(UIImage(named: "nextimagebbt"), for: .normal)
       }
    }
    
}

