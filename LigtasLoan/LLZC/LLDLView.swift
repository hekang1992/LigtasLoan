//
//  LLDLView.swift
//  LigtasLoan
//
//  Created by LigtasLoan on 2024/10/22.
//

import UIKit
import ActiveLabel

class LLDLView: LLBaseView {
    
    var block: (() -> Void)?
    
    lazy var clickLabel: ActiveLabel = {
        let clickLabel = ActiveLabel()
        clickLabel.textAlignment = .left
        clickLabel.textColor = UIColor.init(cssStr: "#050505")?.withAlphaComponent(0.4)
        clickLabel.font = UIFont(name: Regular_SFDisplay, size: 14)
        clickLabel.text = "For a detailed overview of how we manage and process data, kindly refer to our Privacy Policy."
        clickLabel.numberOfLines = 0
        let customType1 = ActiveType.custom(pattern: "\\bPrivacy Policy\\b")
        clickLabel.enabledTypes.append(customType1)
        clickLabel.customColor[customType1] = UIColor.init(cssStr: "#050505")
        clickLabel.handleCustomTap(for: customType1) { [weak self] element in
            self?.block?()
        }
        let attributedString = NSMutableAttributedString(string: clickLabel.text!)
        let redUnderlineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(cssStr: "#2CD7BB") as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.init(cssStr: "#2CD7BB") as Any,
        ]
        let privacyPolicyRange = (clickLabel.text! as NSString).range(of: "Privacy Policy")
        attributedString.addAttributes(redUnderlineAttributes, range: privacyPolicyRange)
        clickLabel.attributedText = attributedString
        return clickLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(clickLabel)
        clickLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTx.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
