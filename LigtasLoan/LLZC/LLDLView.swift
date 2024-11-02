//
//  LLDLView.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit

class LLDLView: LLBaseView {
    
}

class LLYZMView: LLBaseView {
    
    var codeBlock: ((UIButton) -> Void)?
    
    lazy var securityCodeView: WLUnitField = {
        let securityCodeView = WLUnitField(inputUnitCount: 6)
        securityCodeView.borderRadius = 12
        securityCodeView.borderWidth = 0
        securityCodeView.backgroundColor = .white
        securityCodeView.cursorColor = UIColor.init(cssStr: "#5AD7F3")
        securityCodeView.textFont = UIFont(name: Bold_SFDisplay, size: 30)!
        securityCodeView.autoResignFirstResponderWhenInputFinished = true
        return securityCodeView
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle("Send", for: .normal)
        codeBtn.contentHorizontalAlignment = .right
        codeBtn.setTitleColor(UIColor.black, for: .normal)
        codeBtn.titleLabel?.font = UIFont(name: Bold_SFDisplay, size: 18)
        return codeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgImageView.addSubview(securityCodeView)
        bgImageView.addSubview(codeBtn)
        securityCodeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nlabel.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(53)
        }
        codeBtn.snp.makeConstraints { make in
            make.top.equalTo(securityCodeView.snp.bottom).offset(23)
            make.right.equalToSuperview().offset(-11)
            make.size.equalTo(CGSize(width: 90, height: 18))
        }
        
        
        codeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.codeBlock?(self.codeBtn)
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
