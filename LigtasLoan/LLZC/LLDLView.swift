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
    
    lazy var securityCodeView: WLUnitField = {
        let securityCodeView = WLUnitField(inputUnitCount: 6)
        securityCodeView.borderRadius = 12
        securityCodeView.borderWidth = 0
        securityCodeView.backgroundColor = .white
        securityCodeView.textFont = UIFont(name: Bold_Poppins, size: 30)!
        securityCodeView.autoResignFirstResponderWhenInputFinished = true
        return securityCodeView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgImageView.addSubview(securityCodeView)
        securityCodeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nlabel.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(53)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
