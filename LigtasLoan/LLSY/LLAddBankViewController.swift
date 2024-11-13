//
//  LLAddBankViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/11/12.
//

import UIKit

class LLAddBankViewController: LLBaseViewController {
    
    var index: Int = 0
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.mlabel.text = "CHANGE ACCOUNT"
        headView.addBtn.isHidden = false
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
        
        btnView.eBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            btnView.eBtn.setImage(UIImage(named: "wall_sel"), for: .normal)
            btnView.bBtn.setImage(UIImage(named: "Bank"), for: .normal)
//            self.modelArray.accept(self.modelEArray.value)
            self.index = 0
        }).disposed(by: disposeBag)
        
        btnView.bBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.index = 1
            btnView.eBtn.setImage(UIImage(named: "E-Wallet"), for: .normal)
            btnView.bBtn.setImage(UIImage(named: "bank_sel"), for: .normal)
//            self.modelArray.accept(self.modelBArray.value)
        }).disposed(by: disposeBag)
        
        
        headView.addBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let listVc = LLQAWViewController()
            self.navigationController?.pushViewController(listVc, animated: true)
        }).disposed(by: disposeBag)
        
        hqbaInfo()
    }


}

extension LLAddBankViewController {
    
    private func hqbaInfo() {
        LoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["info": "1"], pageURL: "/ll/shouting/small/about", method: .post) { [weak self] result in
            LoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
}
