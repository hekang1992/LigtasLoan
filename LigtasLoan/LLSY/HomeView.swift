//
//  HomeView.swift
//  LigtasLoan
//
//  Created by LigtasLoan on 2024/10/25.
//

import RxSwift
import FSPagerView
import RxRelay

let sc_width = UIScreen.main.bounds.size.width
let sc_height = UIScreen.main.bounds.size.height

class OneView: UIView {
    
    lazy var scro: UIScrollView = {
        let scro = UIScrollView()
        scro.backgroundColor = .white
        scro.showsHorizontalScrollIndicator = false
        scro.showsVerticalScrollIndicator = false
        scro.contentInsetAdjustmentBehavior = .never
        return scro
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "homeonbg")
        ctImageView.isUserInteractionEnabled = true
        return ctImageView
    }()
    
    lazy var mlabel0: UILabel = {
        let mlabel0 = UILabel()
        mlabel0.text = "How to apply?"
        mlabel0.textColor = UIColor.init(cssStr: "#000000")
        mlabel0.textAlignment = .left
        mlabel0.font = UIFont(name: Bold_SFDisplay, size: 14)
        return mlabel0
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "1, Register and log in with your mobile phone number."
        mlabel.numberOfLines = 0
        mlabel.textColor = UIColor.init(cssStr: "#000000")?.withAlphaComponent(0.5)
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 12)
        return mlabel
    }()
    
    lazy var mlabel1: UILabel = {
        let mlabel1 = UILabel()
        mlabel1.text = "2, Complete the information filling and identity verification.\n3, Confirm the loan plan generated for you.\n4, Wait for the approval of the review.\n5, Receive the loan amount."
        mlabel1.numberOfLines = 0
        mlabel1.textColor = UIColor.init(cssStr: "#000000")?.withAlphaComponent(0.5)
        mlabel1.textAlignment = .left
        mlabel1.font = UIFont(name: Bold_SFDisplay, size: 12)
        return mlabel1
    }()
    
    lazy var mlabel2: UILabel = {
        let mlabel2 = UILabel()
        mlabel2.text = "How to make a repayment?"
        mlabel2.textColor = UIColor.init(cssStr: "#000000")
        mlabel2.textAlignment = .left
        mlabel2.font = UIFont(name: Bold_SFDisplay, size: 14)
        return mlabel2
    }()
    
    lazy var ctImageView1: UIImageView = {
        let ctImageView1 = UIImageView()
        ctImageView1.image = UIImage(named: "Downimge")
        ctImageView1.contentMode = .scaleAspectFit
        return ctImageView1
    }()
    
    lazy var ctImageView2: UIImageView = {
        let ctImageView2 = UIImageView()
        ctImageView2.image = UIImage(named: "Downimge")
        ctImageView2.contentMode = .scaleAspectFit
        return ctImageView2
    }()
    
    lazy var mlabel3: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "1, Enter the details page of the orders to be repaid in the application, and click the repayment button or the deferred repayment button at the bottom."
        mlabel.numberOfLines = 0
        mlabel.textColor = UIColor.init(cssStr: "#000000")?.withAlphaComponent(0.5)
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 12)
        return mlabel
    }()
    
    lazy var mlabel4: UILabel = {
        let mlabel1 = UILabel()
        mlabel1.text = "2, Confirm the repayment information.\n3, Select the repayment method.\n4, Obtain the repayment code and make the repayment according to the repayment instructions."
        mlabel1.numberOfLines = 0
        mlabel1.textColor = UIColor.init(cssStr: "#000000")?.withAlphaComponent(0.5)
        mlabel1.textAlignment = .left
        mlabel1.font = UIFont(name: Bold_SFDisplay, size: 12)
        return mlabel1
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        return rightBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scro)
        scro.addSubview(ctImageView)
        ctImageView.addSubview(rightBtn)
        ctImageView.addSubview(mlabel0)
        scro.addSubview(mlabel)
        scro.addSubview(mlabel1)
        scro.addSubview(mlabel2)
        scro.addSubview(ctImageView1)
        scro.addSubview(ctImageView2)
        scro.addSubview(mlabel3)
        scro.addSubview(mlabel4)
        scro.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        ctImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(sc_width)
            make.height.equalTo(613)
        }
        mlabel0.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.bottom.equalTo(ctImageView.snp.bottom)
        }
        mlabel.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(ctImageView.snp.bottom).offset(9)
        }
        mlabel1.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(mlabel.snp.bottom)
        }
        mlabel2.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(mlabel1.snp.bottom).offset(20)
        }
        ctImageView1.snp.makeConstraints { make in
            make.right.equalTo(ctImageView.snp.right).offset(-32)
            make.centerY.equalTo(mlabel2.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        ctImageView2.snp.makeConstraints { make in
            make.right.equalTo(ctImageView.snp.right).offset(-32)
            make.centerY.equalTo(mlabel0.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        mlabel3.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(mlabel2.snp.bottom).offset(9)
        }
        mlabel4.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(mlabel3.snp.bottom)
            make.bottom.equalToSuperview().offset(-40)
        }
        rightBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.right.equalToSuperview().offset(-13)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TwoView: UIView {
    
    var block: ((String) -> Void)?
    
    let disposeBag = DisposeBag()
    
    var model = BehaviorRelay<preferredaModel?>(value: nil)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(cssStr: "#F6F7F6")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(LLProductCell.self, forCellReuseIdentifier: "LLProductCell")
        return tableView
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "t_bg_img")
        ctImageView.isUserInteractionEnabled = true
        return ctImageView
    }()
    
    lazy var whitwView: UIImageView = {
        let whitwView = UIImageView()
        whitwView.isUserInteractionEnabled = true
        whitwView.image = UIImage(named: "repagemen")
        return whitwView
    }()
    
    lazy var lunboView: FSPagerView = {
        let lunboView = FSPagerView()
        lunboView.isInfinite = true
        lunboView.delegate = self
        lunboView.dataSource = self
        lunboView.backgroundColor = .clear
        lunboView.register(LLGunCell.self, forCellWithReuseIdentifier: "LLGunCell")
        return lunboView
    }()
    
    lazy var lunboTeiView: FSPagerView = {
        let lunboTeiView = FSPagerView()
        lunboTeiView.isInfinite = true
        lunboTeiView.delegate = self
        lunboTeiView.dataSource = self
        lunboTeiView.backgroundColor = .clear
        lunboTeiView.register(LLTitleCell.self, forCellWithReuseIdentifier: "LLTitleCell")
        return lunboTeiView
    }()
    
    lazy var clickone: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "procadimagea")
        return ctImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        model
            .compactMap { $0?.greaterone?.aviolence }
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "LLProductCell", cellType: LLProductCell.self)) { row, model, cell in
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                cell.model.accept(model)
            }.disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TwoView: UITableViewDelegate, FSPagerViewDataSource, FSPagerViewDelegate  {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return StatusBarHelper.getStatusBarHeight() + 336
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.addSubview(ctImageView)
        self.ctImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(360)
        }
        
        ctImageView.addSubview(whitwView)
        whitwView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(137)
            make.height.equalTo(40)
        }
        
        whitwView.addSubview(lunboTeiView)
        lunboTeiView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-110)
        }
        
        ctImageView.addSubview(lunboView)
        lunboView.snp.makeConstraints { make in
            make.top.equalTo(whitwView.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
            make.height.equalTo(140)
        }
        
        headView.addSubview(clickone)
        
        clickone.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 116, height: 30))
        }
        
        return headView
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if pagerView == lunboView {
            return model.value?.herplacid?.aviolence.count ?? 0
        }else {
            return model.value?.toldyou?.aviolence?.count ?? 0
        }
        
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if pagerView == lunboView {
            guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "LLGunCell", at: index) as? LLGunCell else { return FSPagerViewCell() }
            let arrayimage = model.value?.herplacid?.aviolence
            let model = arrayimage?[index]
            cell.icon.kf.setImage(with: URL(string: model?.caring ?? ""))
            if arrayimage?.count ?? 0 > 1 {
                lunboView.automaticSlidingInterval = 2
            }else {
                lunboView.automaticSlidingInterval = 0
            }
            return cell
        }else {
            guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "LLTitleCell", at: index) as? LLTitleCell else { return FSPagerViewCell() }
            let arrayimage = model.value?.toldyou?.aviolence
            let model = arrayimage?[index]
            cell.mlabel.text = model?.whey ?? ""
            cell.mlabel.textColor = UIColor.init(cssStr: model?.unawareof ?? "#000000")
            if arrayimage?.count ?? 0 > 1 {
                lunboTeiView.automaticSlidingInterval = 2
            }else {
                lunboTeiView.automaticSlidingInterval = 0
            }
            return cell
        }
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if pagerView == lunboView {
            let model = model.value?.herplacid?.aviolence[index]
            let foryou = model?.foryou ?? ""
            if !foryou.isEmpty {
                self.block?(foryou)
            }
        }else {
            let model = model.value?.toldyou?.aviolence?[index]
            let foryou = model?.foryou ?? ""
            if !foryou.isEmpty {
                self.block?(foryou)
            }
        }
        
    }
    
}

class LLGunCell: FSPagerViewCell {
    
    let disposeBag = DisposeBag()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LLTitleCell: FSPagerViewCell {
    
    let disposeBag = DisposeBag()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.numberOfLines = 2
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 15)
        return mlabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mlabel)
        mlabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class LLHeadBtnClickView: UIView {
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "brnbgim")
        return ctImageView
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .right
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 21)
        return mlabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ctImageView)
        addSubview(mlabel)
        
        ctImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(16)
        }
        mlabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(23)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class LLProductCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var model = BehaviorRelay<aviolenceModel?>(value: nil)
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 8
        return bgView
    }()
    
    lazy var mlabel: PaddedLabel = {
        let mlabel = PaddedLabel()
        mlabel.textColor = UIColor.init(cssStr: "#21FB91")
        mlabel.textAlignment = .center
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 14)
        mlabel.backgroundColor = UIColor.init(cssStr: "#112724")
        mlabel.padding = UIEdgeInsets(top: 1, left: 3, bottom: 1, right: 3)
        return mlabel
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.backgroundColor = UIColor.init(cssStr: "#D9D9D9")
        return ctImageView
    }()
    
    lazy var mylabel: UILabel = {
        let mylabel = UILabel()
        mylabel.textColor = UIColor.init(cssStr: "#000000")
        mylabel.textAlignment = .left
        mylabel.font = UIFont(name: Bold_SFDisplay, size: 24)
        return mylabel
    }()
    
    lazy var deslabel: UILabel = {
        let deslabel = UILabel()
        deslabel.textColor = UIColor.init(cssStr: "#999999")
        deslabel.textAlignment = .left
        deslabel.font = UIFont(name: Regular_SFDisplay, size: 14)
        return deslabel
    }()
    
    lazy var nextlabel: UILabel = {
        let nextlabel = UILabel()
        nextlabel.textColor = UIColor.init(cssStr: "#000000")
        nextlabel.textAlignment = .center
        nextlabel.font = UIFont(name: Bold_SFDisplay, size: 18)
        nextlabel.backgroundColor = UIColor.init(cssStr: "#21FB91")
        return nextlabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(mlabel)
        bgView.addSubview(ctImageView)
        bgView.addSubview(mylabel)
        bgView.addSubview(deslabel)
        bgView.addSubview(nextlabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(17)
        }
        
        mlabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(21)
        }
        ctImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(mlabel.snp.bottom).offset(9)
            make.size.equalTo(CGSize(width: 48, height: 48))
            make.bottom.equalToSuperview().offset(-10)
        }
        mylabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.left.equalTo(ctImageView.snp.right).offset(12)
            make.top.equalTo(mlabel.snp.bottom).offset(7)
        }
        deslabel.snp.makeConstraints { make in
            make.bottom.equalTo(ctImageView.snp.bottom).offset(1)
            make.height.equalTo(21)
            make.left.equalTo(ctImageView.snp.right).offset(12)
        }
        nextlabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(CGSize(width: 89, height: 45))
        }
        
        model.asObservable().subscribe(onNext: { [weak self] mon in
            guard let self = self, let mmo = mon else { return }
            self.mlabel.text = mmo.blot ?? ""
            self.mylabel.text = mmo.itseemed ?? ""
            self.deslabel.text = mmo.toanyone ?? ""
            self.ctImageView.kf.setImage(with: URL(string: mmo.makeyou ?? ""))
            let thenyou = mmo.thenyou ?? ""
            self.nextlabel.isHidden = thenyou.isEmpty
            if !thenyou.isEmpty {
                self.nextlabel.text = mmo.thenyou ?? ""
            }
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PaddedLabel: UILabel {
    var padding: UIEdgeInsets = .zero
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right)
        let paddedRect = rect.inset(by: insets)
        super.drawText(in: paddedRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let widthWithPadding = size.width + padding.left + padding.right
        let heightWithPadding = size.height + padding.top + padding.bottom
        return CGSize(width: widthWithPadding, height: heightWithPadding)
    }
}
