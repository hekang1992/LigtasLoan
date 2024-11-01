//
//  LLStepTHRViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/30.
//

import UIKit
import RxRelay

class LLStepTHRViewController: LLBaseViewController {
    
    var lo = BehaviorRelay<String>(value: "")
    
    var modelArray = BehaviorRelay<[widehallModel]>(value: [])
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.mlabel.text = "WORK INFORMATION"
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

extension LLStepTHRViewController: UITableViewDelegate {
    
    private func handleStorySelection(_ model: widehallModel, cell: LLBtnClickCell) {
        let underthe = model.underthe ?? ""
        switch underthe {
        case "story1":
            print("story1")
            if let theirbeauty = model.theirbeauty {
                let modelArray = OnePopConfig.getOneDetails(dataSourceArr: theirbeauty)
                OneTwoThreePopConfig.popLastEnum(.province, cell.mlabel1, modelArray, model) {
                    
                }
            }
        case "story2":
            print("story2")
        case "story3":
            print("story3")
            fetchStoryData(for: cell)
        case "story4":
            print("story4")
        default:
            break
        }
    }
    
    private func fetchStoryData(for cell: LLBtnClickCell) {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["": ""], pageUrl: "/ll/after/tomcat/foreverrankled", method: .get) { result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                if let unending = success.preferreda.unending, let model = cell.model.value {
                    let modelArray = SanPopConfig.SanChengArray(dataArr: unending)
                    OneTwoThreePopConfig.popLastEnum(.area, cell.mlabel1, modelArray, model) {
                        
                    }
                }
            case .failure(let failure):
                print("\(failure.localizedDescription)")
            }
        }
    }
    
    
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
            nextBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.bcinfo()
            }).disposed(by: disposeBag)
        }
        return footView
    }
    
    private func mesinfo() {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["lo": lo.value], pageUrl: "/ll/mating/cookie/andmelanie", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
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
    
    private func bcinfo() {
        var dict: [String: Any]?
        dict = modelArray.value.reduce(into: [String: Any](), { preesult, model in
            let type = model.underthe
            if type == "story1" || type == "story4" {
                preesult[model.andmammy!] = model.elemental
            }else {
                preesult[model.andmammy!] = model.butshe
            }
        })
        dict?["eat"] = "apple"
        dict?["lo"] = lo.value
        dict?["bidding"] = "1"
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: dict, pageUrl: "/ll/thisdignity/their/unbroken", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(let success):
                let gabbling = success.preferreda.hisgold?.gabbling ?? ""
                self.nextvc(form: gabbling, proid: lo.value)
                break
            case .failure(let failure):
                break
            }
        }
    }
    
}
