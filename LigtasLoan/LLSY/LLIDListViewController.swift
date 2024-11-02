//
//  LLIDListViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/26.
//

import UIKit
import RxRelay
import Kingfisher

class HeadView: UIView {
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "Frame"), for: .normal)
        return backBtn
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .center
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 16)
        return mlabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(backBtn)
        bgView.addSubview(mlabel)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHelper.getStatusBarHeight() + 14)
            make.left.equalToSuperview().offset(33)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        mlabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn.snp.centerY)
            make.height.equalTo(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class IDListView: UIView {
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.mlabel.text = "SELECT ID TYPE"
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headView)
        addSubview(tableView)
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHelper.getStatusBarHeight() + 56)
        }
        tableView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ListCell: UITableViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(cssStr: "#F6F7F6")
        return bgView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.contentMode = .scaleAspectFill
        return ctImageView
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 14)
        return mlabel
    }()
    
    lazy var riImageView: UIImageView = {
        let riImageView = UIImageView()
        riImageView.image = UIImage(named: "righticon")
        riImageView.contentMode = .scaleAspectFill
        return riImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(whiteView)
        whiteView.addSubview(ctImageView)
        whiteView.addSubview(mlabel)
        whiteView.addSubview(riImageView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(48)
            make.bottom.equalToSuperview()
        }
        ctImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 31))
            make.left.equalToSuperview().offset(12)
        }
        riImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
            make.right.equalToSuperview().offset(-15)
        }
        mlabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(ctImageView.snp.right).offset(12)
            make.height.equalTo(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}







//++++++++++++++++++++++++++++++++++++++++++++++++++++



class LLIDListViewController: LLBaseViewController {
    
    lazy var listView: IDListView = {
        let listView = IDListView()
        listView.backgroundColor = .init(cssStr: "#F6F7F6")
        return listView
    }()
    
    var lo = BehaviorRelay<String>(value: "")
    
    var picModelArray = BehaviorRelay<[widehallModel]>(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        listView.headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        listInfo()
        
        listView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        picModelArray.asObservable().bind(to: listView.tableView.rx.items(cellIdentifier: "ListCell", cellType: ListCell.self)) { index, model, cell in
            cell.mlabel.text = model.aquizzical ?? ""
            cell.ctImageView.kf.setImage(with: URL(string: model.pic_url ?? ""))
        }.disposed(by: disposeBag)
        
        listView.tableView.rx.modelSelected(widehallModel.self).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            print("type:\(model.aquizzical ?? "")")
            let vc = LLUploadIDViewController()
            vc.type.accept(model.aquizzical ?? "")
            vc.lo.accept(self.lo.value)
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
    }

}


extension LLIDListViewController: UITableViewDelegate {
    
    private func listInfo() {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["card": "pp"], pageUrl: "ll/looked/either/ellen", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                let model = success.preferreda
                if let picModelArray = model.unending {
                    self?.picModelArray.accept(picModelArray)
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
}
