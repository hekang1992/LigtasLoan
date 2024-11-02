//
//  LLQAWViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/11/2.
//

import UIKit
import RxRelay

class LLQAWView: UIView {
    
    lazy var eBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "wall_sel"), for: .normal)
        return backBtn
    }()
    
    lazy var bBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "Bank"), for: .normal)
        return backBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(eBtn)
        addSubview(bBtn)
        
        eBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(6)
            make.size.equalTo(CGSize(width: 87, height: 17))
        }
        bBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(6)
            make.size.equalTo(CGSize(width: 87, height: 17))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






//+++++++++++++++++++++++++++++++++++++++++++++++++++





class LLQAWViewController: LLBaseViewController {
    
    var index: Int = 0
    
    var modelArray = BehaviorRelay<[widehallModel]>(value: [])
    
    var modelEArray = BehaviorRelay<[widehallModel]>(value: [])
    
    var modelBArray = BehaviorRelay<[widehallModel]>(value: [])
    
    var lo = BehaviorRelay<String>(value: "")
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.mlabel.text = "E-WALLET & BANK"
        return headView
    }()
    
    lazy var btnView: LLQAWView = {
        let btnView = LLQAWView()
        btnView.backgroundColor = .white
        return btnView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(cssStr: "#F6F7F6")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(LLInputCell.self, forCellReuseIdentifier: "LLInputCell")
        tableView.register(LLBtnClickCell.self, forCellReuseIdentifier: "LLBtnClickCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHelper.getStatusBarHeight() + 56)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.pushlistvc()
        }).disposed(by: disposeBag)
        
        view.addSubview(btnView)
        btnView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(btnView.snp.bottom)
        }
        
        hqwqinfo()
        
        btnView.eBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            btnView.eBtn.setImage(UIImage(named: "wall_sel"), for: .normal)
            btnView.bBtn.setImage(UIImage(named: "Bank"), for: .normal)
            self.modelArray.accept(self.modelEArray.value)
            self.index = 0
        }).disposed(by: disposeBag)
        
        btnView.bBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.index = 1
            btnView.eBtn.setImage(UIImage(named: "E-Wallet"), for: .normal)
            btnView.bBtn.setImage(UIImage(named: "bank_sel"), for: .normal)
            self.modelArray.accept(self.modelBArray.value)
        }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        modelArray.asObservable().bind(to: tableView.rx.items) { [weak self] tableView, index, model in
            guard let self = self else { return  UITableViewCell()}
            let underthe = model.underthe ?? ""
            if underthe == "story2" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "LLInputCell", for: IndexPath(row: index, section: 0)) as? LLInputCell  {
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    cell.model.accept(model)
                    if model.risked == "1" {
                        cell.inputtx.keyboardType = .numberPad
                    }else {
                        cell.inputtx.keyboardType = .default
                    }
                    cell.inputtx.rx.text.orEmpty.subscribe(onNext: { text in
                        model.butshe = text
                    }).disposed(by: disposeBag)
                    return cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "LLBtnClickCell", for: IndexPath(row: index, section: 0)) as? LLBtnClickCell  {
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    cell.model.accept(model)
                    return cell
                }
            }
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.view.endEditing(true)
                let model = self.modelArray.value[indexPath.row]
                guard let cell = tableView.cellForRow(at: indexPath) as? LLBtnClickCell else { return }
                self.handleStorySelection(model, cell: cell)
            })
            .disposed(by: disposeBag)
    }
    
}

extension LLQAWViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return modelArray.value.count != 0 ? 90 : 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        if modelArray.value.count != 0 {
            let nextBtn = UIButton(type: .custom)
            nextBtn.backgroundColor = UIColor.init(cssStr: "#222222")
            nextBtn.setTitle("NEXT STEP", for: .normal)
            nextBtn.setTitleColor(UIColor.init(cssStr: "#1EFB91"), for: .normal)
            nextBtn.titleLabel?.font = UIFont(name: Bold_SFDisplay, size: 18)
            footView.addSubview(nextBtn)
            nextBtn.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(12)
                make.height.equalTo(56)
            }
            nextBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.bcinfo()
            }).disposed(by: disposeBag)
        }
        return footView
    }
    
    private func hqwqinfo() {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["withouthaving": "1", "hamper": "0", "bind": "0"], pageUrl: "/ll/which/stuart/andcolorful", method: .get) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if let modelArray = success.preferreda.widehall, let fi = modelArray.first?.widehall, let la = modelArray.last?.widehall {
                    self.modelArray.accept(fi)
                    self.modelEArray.accept(fi)
                    self.modelBArray.accept(la)
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    private func bcinfo() {
        var dict: [String: Any]?
        dict = modelArray.value.reduce(into: [String: Any](), { preesult, model in
            let underthe = model.underthe
            if underthe == "story1" || underthe == "story4" {
                preesult[model.andmammy!] = model.elemental
            }else {
                preesult[model.andmammy!] = model.butshe
            }
        })
        dict?["hearth"] = index + 1
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: dict, pageUrl: "/ll/slave/evidence/characteristics", method: .post) { [weak self] result in
            guard let self = self else { return }
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                self.pageinDetailInfo(from: lo.value)
                break
            case .failure(let failure):
                break
            }
        }
    }
    
}
