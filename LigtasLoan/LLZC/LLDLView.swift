//
//  LLDLView.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit
import QuickSecurityCode

class LLDLView: LLBaseView {
    
}

class LLYZMView: LLBaseView {
    
    lazy var securityCodeView: QuickSecurityCode = {
        let securityCodeView = QuickSecurityCode()
        securityCodeView.preferredSixDigits = true
        securityCodeView.focusBorderColor = .clear
        securityCodeView.digitFont = UIFont(name: Bold_Poppins, size: 30)
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
