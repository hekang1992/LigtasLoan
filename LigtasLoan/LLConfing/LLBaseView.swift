//
//  LLBaseView.swift
//  LigtasLoan
//
//  Created by LigtasLoan on 2024/10/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
import RxGesture
import RxDataSources
import Toaster

class LLBaseView: UIView {
    
    let disposeBag = DisposeBag()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "llbasebg")
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "Frame"), for: .normal)
        return backBtn
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "Grouphhe")
        ctImageView.contentMode = .scaleAspectFill
        return ctImageView
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "Enter phone number"
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 24)
        return mlabel
    }()
    
    lazy var nlabel: UILabel = {
        let nlabel = UILabel()
        nlabel.numberOfLines = 0
        nlabel.text = "Enter your phone number, if not registered, it will be automatically registered."
        nlabel.textColor = UIColor.init(cssStr: "#CCCCCC")
        nlabel.textAlignment = .left
        nlabel.font = UIFont(name: Bold_SFDisplay, size: 12)
        return nlabel
    }()
    
    
    lazy var sImageView: UIImageView = {
        let sImageView = UIImageView()
        sImageView.image = UIImage(named: "shurukuangimage")
        sImageView.contentMode = .scaleAspectFill
        sImageView.isUserInteractionEnabled = true
        return sImageView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.isEnabled = false
        nextBtn.setImage(UIImage(named: "nextimagebbt"), for: .normal)
        return nextBtn
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter phone number", attributes: [
            .foregroundColor: UIColor.init(cssStr: "#000000")?.withAlphaComponent(0.2) as Any,
            .font: UIFont(name: Bold_SFDisplay, size: 12)!
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont(name: Bold_SFDisplay, size: 24)
        phoneTx.textColor = UIColor.init(cssStr: "#000000")
        return phoneTx
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(backBtn)
        bgImageView.addSubview(ctImageView)
        bgImageView.addSubview(mlabel)
        bgImageView.addSubview(nlabel)
        bgImageView.addSubview(sImageView)
        sImageView.addSubview(phoneTx)
        bgImageView.addSubview(nextBtn)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHelper.getStatusBarHeight() + 11)
            make.left.equalToSuperview().offset(33)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        ctImageView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(29)
            make.left.equalToSuperview().offset(32)
            make.size.equalTo(CGSize(width: 94, height: 64))
        }
        mlabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(ctImageView.snp.bottom).offset(25)
            make.height.equalTo(25)
        }
        nlabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31)
            make.top.equalTo(mlabel.snp.bottom).offset(11)
            make.right.equalToSuperview().offset(-16)
        }
        sImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nlabel.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(60)
        }
        phoneTx.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.top.equalToSuperview()
            make.left.equalToSuperview().offset(105)
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(sImageView.snp.bottom).offset(88)
            make.size.equalTo(CGSize(width: 126, height: 56))
        }
        
        nextBtn.rx.tap.subscribe(onNext: {
            
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ToastUtility {
    static func showToast(message: String) {
        ToastView.appearance().font = UIFont(name: Bold_SFDisplay, size: 20)
        let toast = Toast(text: message, duration: 1.0)
        if let window = UIApplication.shared.windows.first {
            let screenHeight = window.frame.size.height
            let toastHeight: CGFloat = 50
            let centerY = screenHeight / 2 - toastHeight / 2
            ToastView.appearance().bottomOffsetPortrait = centerY
            ToastView.appearance().bottomOffsetLandscape = centerY
        }
        toast.show()
    }
}
