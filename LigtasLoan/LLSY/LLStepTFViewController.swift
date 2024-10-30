//
//  LLStepTFViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/30.
//

import UIKit
import RxRelay
import RxSwift
import Contacts
import ContactsUI

class LLPhontClickCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var model = BehaviorRelay<widehallModel?>(value: nil)
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_Poppins, size: 16)
        return mlabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(cssStr: "#FFFFFF")
        bgView.layer.cornerRadius = 4
        return bgView
    }()
    
    lazy var bgView1: UIView = {
        let bgView1 = UIView()
        bgView1.backgroundColor = .init(cssStr: "#FFFFFF")
        bgView1.layer.cornerRadius = 4
        return bgView1
    }()
    
    lazy var mlabel1: UILabel = {
        let mlabel1 = UILabel()
        mlabel1.textColor = UIColor.init(cssStr: "#000000").withAlphaComponent(0.2)
        mlabel1.textAlignment = .left
        mlabel1.font = UIFont(name: Bold_Poppins, size: 16)
        return mlabel1
    }()
    
    lazy var mlabel2: UILabel = {
        let mlabel2 = UILabel()
        mlabel2.textColor = UIColor.init(cssStr: "#000000").withAlphaComponent(0.2)
        mlabel2.textAlignment = .left
        mlabel2.font = UIFont(name: Bold_Poppins, size: 16)
        return mlabel2
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "righticon")
        ctImageView.contentMode = .scaleAspectFit
        return ctImageView
    }()
    
    lazy var ctImageView1: UIImageView = {
        let ctImageView1 = UIImageView()
        ctImageView1.image = UIImage(named: "righticon")
        ctImageView1.contentMode = .scaleAspectFit
        return ctImageView1
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mlabel)
        contentView.addSubview(bgView)
        contentView.addSubview(bgView1)
        bgView.addSubview(mlabel1)
        bgView.addSubview(ctImageView)
        bgView1.addSubview(mlabel2)
        bgView1.addSubview(ctImageView1)
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
        }
        mlabel1.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(sc_width - 50)
            make.left.equalToSuperview().offset(12)
        }
        ctImageView.snp.makeConstraints { make in
            make.centerY.equalTo(mlabel1.snp.centerY)
            make.size.equalTo(CGSize(width: 24, height: 24))
            make.right.equalToSuperview().offset(-35)
        }
        
        bgView1.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 30)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(bgView.snp.bottom).offset(12)
            make.height.equalTo(65)
            make.bottom.equalToSuperview()
        }
        mlabel2.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(sc_width - 50)
            make.left.equalToSuperview().offset(12)
        }
        ctImageView1.snp.makeConstraints { make in
            make.centerY.equalTo(mlabel2.snp.centerY)
            make.size.equalTo(CGSize(width: 24, height: 24))
            make.right.equalToSuperview().offset(-35)
        }
        
        model.subscribe(onNext: { [weak self] imodel in
            guard let self = self, let imodel = imodel else { return }
            mlabel.text = imodel.hatred ?? ""
            mlabel1.text = imodel.throwingher ?? ""
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


















//+++++++++++++++++++++++++++++++++++++++++++





class LLStepTFViewController: LLBaseViewController {
    
    var lo = BehaviorRelay<String>(value: "")
    
    var modelArray = BehaviorRelay<[unendingModel]>(value: [])
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.mlabel.text = "EMERGENCY CONTACT"
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
        tableView.register(LLPhontClickCell.self, forCellReuseIdentifier: "LLPhontClickCell")
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
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
        mesinfo()
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        modelArray.asObservable().bind(to: tableView.rx.items(cellIdentifier: "LLPhontClickCell", cellType: LLPhontClickCell.self)) { index, model, cell in
            cell.mlabel.text = model.haddreamed ?? ""
            cell.mlabel1.text = "Relationship"
            cell.mlabel2.text = "Name and phone"
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(unendingModel.self).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            HQQuanXianConig.canPer { scure in
                if scure {
                    
                }else {
                    HQQuanXianConig.showAlert(in: self, title: "Access to contacts is necessary.", message: "To use this feature, please allow contact access in your Settings.")
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
}


extension LLStepTFViewController: UITableViewDelegate {
    
    private func mesinfo() {
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.requestAPI(params: ["lo": lo.value, "base": "common"], pageUrl: "/ll/these/color/would", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                let model = success.preferreda
                if let modelArray = model.andfalling?.unending, let self = self {
                    self.modelArray.accept(modelArray)
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
                //                self.bcinfo()
            }).disposed(by: disposeBag)
        }
        return footView
    }
    
}


typealias ContactsPCompletion = ((Bool) -> Void)

class HQQuanXianConig: NSObject, CNContactPickerDelegate {
    
    static func canPer(completion: @escaping ContactsPCompletion) {
        let contactStore = CNContactStore()
        Task {
            let accessGranted = await requestAccessIfNeeded(contactStore: contactStore)
            completion(accessGranted)
        }
    }
    
    private static func requestAccessIfNeeded(contactStore: CNContactStore) async -> Bool {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            do {
                let granted = try await contactStore.requestAccess(for: .contacts)
                return granted
            } catch {
                return false
            }
        case .denied, .restricted:
            return false
        case .limited:
            return false
        @unknown default:
            return false
        }
    }
    
    static func showAlert(in viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let section = UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(appSettingsURL) {
                    UIApplication.shared.open(appSettingsURL, options: [:], completionHandler: nil)
                }
            }
        }
        alertController.addAction(cAction)
        alertController.addAction(section)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
