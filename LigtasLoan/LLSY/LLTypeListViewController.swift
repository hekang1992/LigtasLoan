//
//  LLTypeListViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/25.
//

import UIKit
import RxRelay
import ActiveLabel

class SelListView: UIView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.adjustsImageWhenHighlighted = false
        return backBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(backBtn)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 92))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ListView: UIView {
    
    lazy var scro: UIScrollView = {
        let scro = UIScrollView()
        scro.backgroundColor = .white
        scro.showsHorizontalScrollIndicator = false
        scro.showsVerticalScrollIndicator = false
        scro.contentInsetAdjustmentBehavior = .never
        return scro
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        return backBtn
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "securefda")
        ctImageView.contentMode = .scaleAspectFill
        ctImageView.isUserInteractionEnabled = true
        return ctImageView
    }()
    
    lazy var listView1: SelListView = {
        let listView1 = SelListView()
        listView1.backBtn.setImage(UIImage(named: "Groid"), for: .normal)
        return listView1
    }()
    
    lazy var listView2: SelListView = {
        let listView2 = SelListView()
        listView2.backBtn.setImage(UIImage(named: "Groubas"), for: .normal)
        return listView2
    }()
    
    lazy var listView3: SelListView = {
        let listView3 = SelListView()
        listView3.backBtn.setImage(UIImage(named: "Grouwosk"), for: .normal)
        return listView3
    }()
    
    lazy var listView4: SelListView = {
        let listView4 = SelListView()
        listView4.backBtn.setImage(UIImage(named: "Groulixi"), for: .normal)
        return listView4
    }()
    
    lazy var listView5: SelListView = {
        let listView5 = SelListView()
        listView5.backBtn.setImage(UIImage(named: "Grouyinhna"), for: .normal)
        return listView5
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.backgroundColor = UIColor.init(cssStr: "#222222")
        nextBtn.setTitle("GO CERTIFICATION", for: .normal)
        nextBtn.titleLabel?.font = UIFont(name: Bold_Poppins, size: 15)
        return nextBtn
    }()
    
    lazy var clickLabel: ActiveLabel = {
        let clickLabel = ActiveLabel()
        clickLabel.textAlignment = .center
        clickLabel.textColor = UIColor.init(cssStr: "#050505").withAlphaComponent(0.4)
        clickLabel.font = UIFont(name: Regular_Poppins, size: 14)
        clickLabel.text = "For a detailed overview of how we manage and process data, kindly refer to our Privacy Policy."
        clickLabel.numberOfLines = 0
        let customType1 = ActiveType.custom(pattern: "\\bPrivacy Policy\\b")
        clickLabel.enabledTypes.append(customType1)
        clickLabel.customColor[customType1] = UIColor.init(cssStr: "#050505")
        clickLabel.handleCustomTap(for: customType1) { [weak self] element in
            ToastUtility.showToast(message: "Privacy")
        }
        let attributedString = NSMutableAttributedString(string: clickLabel.text!)
        let redUnderlineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(cssStr: "#2CD7BB"),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.init(cssStr: "#2CD7BB"),
        ]
        let privacyPolicyRange = (clickLabel.text! as NSString).range(of: "Privacy Policy")
        attributedString.addAttributes(redUnderlineAttributes, range: privacyPolicyRange)
        clickLabel.attributedText = attributedString
        return clickLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scro)
        scro.addSubview(ctImageView)
        ctImageView.addSubview(backBtn)
        scro.addSubview(listView1)
        scro.addSubview(listView2)
        scro.addSubview(listView3)
        scro.addSubview(listView4)
        scro.addSubview(listView5)
        scro.addSubview(nextBtn)
        scro.addSubview(clickLabel)
        scro.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        ctImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(sc_width)
            make.height.equalTo(334)
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHelper.getStatusBarHeight())
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        listView1.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(sc_width)
            make.height.equalTo(92)
            make.top.equalTo(ctImageView.snp.bottom).offset(1)
        }
        listView2.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(sc_width)
            make.height.equalTo(92)
            make.top.equalTo(listView1.snp.bottom).offset(1)
        }
        listView3.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(sc_width)
            make.height.equalTo(92)
            make.top.equalTo(listView2.snp.bottom).offset(1)
        }
        listView4.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(sc_width)
            make.height.equalTo(92)
            make.top.equalTo(listView3.snp.bottom).offset(1)
        }
        listView5.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(sc_width)
            make.height.equalTo(92)
            make.top.equalTo(listView4.snp.bottom).offset(1)
        }
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(listView5.snp.bottom).offset(21)
            make.height.equalTo(56)
            make.width.equalTo(sc_width - 25)
        }
        clickLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(21)
            make.width.equalTo(sc_width - 42)
            make.top.equalTo(nextBtn.snp.bottom).offset(32)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LLTypeListViewController: LLBaseViewController {
    
    var lo = BehaviorRelay<String>(value: "")
    
    var nextStr = BehaviorRelay<String>(value: "")
    
    lazy var listView: ListView = {
        let listView = ListView()
        return listView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        listView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        tapClick()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        proDetailInfo(from: lo.value)
    }
    
}

extension LLTypeListViewController {
    
    private func tapClick() {
        listView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.nextvc(form: self.nextStr.value, proid: self.lo.value)
        }).disposed(by: disposeBag)
    }
    
    override func proDetailInfo(from proid: String) {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["lo": proid, "sooddly": "1", "shoothim": "0"], pageUrl: "/ll/another/between/healthy", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success.andmammy == 0 || success.andmammy == 00 {
                    if let hisgold = success.preferreda.hisgold {
                        self.nextStr.accept(hisgold.gabbling ?? "")
                        self.nextListTy(form: hisgold.gabbling ?? "")
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    private func nextListTy(form type: String) {
        switch type {
        case "eastern1":
            break
        case "eastern2":
            listView.listView1.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            break
        case "eastern3":
            listView.listView1.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            listView.listView2.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            break
        case "eastern4":
            listView.listView1.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            listView.listView2.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            listView.listView3.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            break
        case "eastern5":
            listView.listView1.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            listView.listView2.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            listView.listView3.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            listView.listView4.bgView.backgroundColor = UIColor.init(cssStr: "#1EFB91")
            break
        default:
            break
        }
    }
    
    func nextvc(form type: String, proid: String) {
        if type == "eastern1" {
            self.huoquid(from: proid)
        }
    }
    
    func huoquid(from proid: String) {
        let man = LLRequestManager()
        ViewLoadingManager.addLoadingView()
        man.requestAPI(params: ["lo": proid, "recallanything": "happy"], pageUrl: "/ll/sitting/troop/affection", method: .get) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                let model = success.preferreda
                if let dully = model.toremember?.dully, let self = self {
                    if dully == 0 {
                        self.goIDvC()
                    }else {
                        
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func goIDvC() {
        let vc = LLIDListViewController()
        vc.lo.accept(lo.value)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
