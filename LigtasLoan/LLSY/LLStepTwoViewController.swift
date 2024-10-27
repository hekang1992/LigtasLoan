//
//  LLStepTwoViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/27.
//

import UIKit
import RxRelay

class LLInputCell: UITableViewCell {
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_Poppins, size: 16)
        mlabel.text = "LigtasLoan"
        return mlabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(cssStr: "#FFFFFF")
        bgView.layer.cornerRadius = 4
        return bgView
    }()
    
    lazy var inputtx: UITextField = {
        let inputtx = UITextField()
        inputtx.font = UIFont(name: Bold_Poppins, size: 16)
        inputtx.textColor = UIColor.init(cssStr: "#000000").withAlphaComponent(0.5)
        return inputtx
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mlabel)
        contentView.addSubview(bgView)
        bgView.addSubview(inputtx)
        
        mlabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(20)
        }
        bgView.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 30)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(mlabel.snp.bottom).offset(8)
            make.height.equalTo(65)
            make.bottom.equalToSuperview()
        }
        inputtx.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(sc_width - 50)
            make.left.equalToSuperview().offset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




class LLBtnClickCell: UITableViewCell {
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_Poppins, size: 16)
        mlabel.text = "LigtasLoan"
        return mlabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(cssStr: "#FFFFFF")
        bgView.layer.cornerRadius = 4
        return bgView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.contentHorizontalAlignment = .left
        nextBtn.setTitleColor(UIColor.init(cssStr: "#000000").withAlphaComponent(0.5), for: .normal)
        nextBtn.titleLabel?.font = UIFont(name: Bold_Poppins, size: 16)
        return nextBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mlabel)
        contentView.addSubview(bgView)
        bgView.addSubview(nextBtn)
        
        mlabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(20)
        }
        bgView.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 30)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(mlabel.snp.bottom).offset(8)
            make.height.equalTo(65)
            make.bottom.equalToSuperview()
        }
        nextBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(sc_width - 50)
            make.left.equalToSuperview().offset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






















//+++++++++++++++++++++++++++++++++++++++++++++++++++









class LLStepTwoViewController: LLBaseViewController {
    
    var lo = BehaviorRelay<String>(value: "")
    
    var modelArray = BehaviorRelay<[widehallModel]>(value: [])
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.mlabel.text = "ID CARD INFORMATION"
        return headView
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
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHelper.getStatusBarHeight() + 56)
        }
        
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.pushlistvc()
        }).disposed(by: disposeBag)
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        mesinfo()
        
        modelArray.asObservable().bind(to: tableView.rx.items) { tableView, index, model in
            let underthe = model.underthe ?? ""
            if underthe == "story2" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "LLInputCell", for: IndexPath(row: index, section: 0)) as? LLInputCell  {
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    return cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "LLBtnClickCell", for: IndexPath(row: index, section: 0)) as? LLBtnClickCell  {
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    return cell
                }
            }
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
    }
    
}

extension LLStepTwoViewController: UITableViewDelegate {
    
    
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
            nextBtn.titleLabel?.font = UIFont(name: Bold_Poppins, size: 18)
            footView.addSubview(nextBtn)
            nextBtn.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(12)
                make.height.equalTo(56)
            }
        }
        return footView
    }
    
    private func mesinfo() {
        let man = LLRequestManager()
        man.requestAPI(params: ["lo": lo.value], pageUrl: "/ll/would/sitting/everyone", method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                let model = success.preferreda
                if let modelArray = model.widehall, let self = self {
                    self.modelArray.accept(modelArray)
                }
                break
            case .failure(_):
                break
            }
        }
        
    }
    
}
