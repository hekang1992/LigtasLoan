//
//  LLRightViewController.swift
//  LigtasLoan
//
//  Created by LigtasLoan on 2024/10/25.
//

import UIKit
import RxSwift
import TYAlertController

class DelView: UIView {
    
    var block: (() -> Void)?
    var block1: (() -> Void)?
    
    let disposeBag = DisposeBag()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.contentMode = .scaleAspectFit
        ctImageView.isUserInteractionEnabled = true
        return ctImageView
    }()
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        return btn1
    }()
    
    lazy var btn2: UIButton = {
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "altcancel"), for: .normal)
        return btn2
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ctImageView)
        ctImageView.addSubview(btn1)
        ctImageView.addSubview(btn2)
        
        ctImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 363))
        }
        btn1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 320, height: 56))
            make.top.equalToSuperview().offset(223)
        }
        btn2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 320, height: 56))
            make.top.equalTo(btn1.snp.bottom).offset(13)
        }
        
        btn1.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disposeBag)
        btn2.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class LLRightView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(cssStr: "#FFFFFF")
        return scrollView
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "iconim")
        ctImageView.contentMode = .scaleAspectFit
        return ctImageView
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        let phone = UserDefaults.standard.object(forKey: LL_LOGIN) as? String ?? ""
        mlabel.text = phone
        mlabel.textColor = UIColor.init(cssStr: "#0F0B03")
        mlabel.textAlignment = .center
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 18)
        return mlabel
    }()
    
    lazy var itemView1: LLRightItemView = {
        let itemView1 = LLRightItemView()
        itemView1.mlabel.text = "List Of Orders"
        return itemView1
    }()
    
    lazy var itemView2: LLRightItemView = {
        let itemView2 = LLRightItemView()
        itemView2.mlabel.text = "The Official Site"
        return itemView2
    }()
    
    lazy var itemView3: LLRightItemView = {
        let itemView3 = LLRightItemView()
        itemView3.mlabel.text = "Get in Touch With Us"
        return itemView3
    }()
    
    lazy var itemView4: LLRightItemView = {
        let itemView4 = LLRightItemView()
        itemView4.mlabel.text = "Configuration"
        return itemView4
    }()
    
    lazy var itemView5: LLRightItemView = {
        let itemView5 = LLRightItemView()
        itemView5.mlabel.text = "Delete Account"
        return itemView5
    }()
    
    lazy var itemView6: LLRightItemView = {
        let itemView6 = LLRightItemView()
        itemView6.mlabel.text = "Log Out"
        return itemView6
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(ctImageView)
        scrollView.addSubview(mlabel)
        scrollView.addSubview(itemView1)
        scrollView.addSubview(itemView2)
        scrollView.addSubview(itemView3)
        scrollView.addSubview(itemView4)
        scrollView.addSubview(itemView5)
        scrollView.addSubview(itemView6)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        ctImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(StatusBarHelper.getStatusBarHeight() + 10)
            make.size.equalTo(CGSize(width: 106, height: 106))
        }
        mlabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ctImageView.snp.bottom).offset(9)
            make.height.equalTo(36)
        }
        itemView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mlabel.snp.bottom).offset(29)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
        itemView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(itemView1.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
        itemView3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(itemView2.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
        itemView4.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(itemView3.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
        itemView5.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(itemView4.snp.bottom).offset(150)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(50)
        }
        itemView6.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(itemView5.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-48)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LLRightItemView: UIView {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.backgroundColor = UIColor.init(cssStr: "#F6F7F6")
        return bgView
    }()

    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 15)
        return mlabel
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "righticon")
        return iconImageView
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(mlabel)
        bgView.addSubview(iconImageView)
        bgView.addSubview(btn)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(50)
        }
        mlabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.top.equalToSuperview()
            make.right.equalToSuperview().offset(-60)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        btn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








//+++++++++++++++++++++++++++++++++++++++++++++++++++++


#warning("")









class LLRightViewController: LLBaseViewController {
    
    lazy var rightView: LLRightView = {
        let rightView = LLRightView()
        return rightView
    }()
    
    lazy var delView: DelView = {
        let delView = DelView(frame: UIScreen.main.bounds)
        return delView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rightView)
        rightView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tap()
    }
    
}

extension LLRightViewController {
    
    private func tap() {
        rightView.itemView1.btn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let setVc = LLAllDianViewController()
            self.gy_sidePushViewController(viewController: setVc)
        }).disposed(by: disposeBag)
        
        rightView.itemView2.btn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
        }).disposed(by: disposeBag)
        
        rightView.itemView3.btn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
        }).disposed(by: disposeBag)
        
        rightView.itemView4.btn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let setVc = LLSetingViewController()
            self.gy_sidePushViewController(viewController: setVc)
        }).disposed(by: disposeBag)
        
        rightView.itemView5.btn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.delView.ctImageView.image = UIImage(named: "dellimagepu")
            self.delView.btn1.setImage(UIImage(named: "aldel"), for: .normal)
            let alertVc = TYAlertController(alert: self.delView, preferredStyle: .alert)
            self.present(alertVc!, animated: true)
            self.delView.block = {
                self.delInfo()
            }
            self.delView.block1 = {
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
        
        rightView.itemView6.btn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.delView.ctImageView.image = UIImage(named: "outimage")
            self.delView.btn1.setImage(UIImage(named: "eximIMGE"), for: .normal)
            let alertVc = TYAlertController(alert: self.delView, preferredStyle: .alert)
            self.present(alertVc!, animated: true)
            self.delView.block = {
                self.logInfo()
            }
            self.delView.block1 = {
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    private func delInfo() {
        LoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["del": "1", "cost": "cent"], pageURL: "/ll/education/social/gather", method: .get) { result in
            LoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                if success.andmammy == 0 || success.andmammy == 00 {
                    DispatchQueue.main.async {
                        LLDLInfo.removedlInfo()
                        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    private func logInfo() {
        LoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["thatstupid": "1", "silenceanything": "trump"], pageURL: "/ll/mothers/spring/journeyed", method: .get) { result in
            LoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                if success.andmammy == 0 || success.andmammy == 00 {
                    DispatchQueue.main.async {
                        LLDLInfo.removedlInfo()
                        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
}
