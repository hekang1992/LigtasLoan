//
//  LLZCViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit
import RxSwift

class LLZCViewController: LLBaseViewController {
    
    lazy var loginView: LLDLView = {
        let loginView = LLDLView()
        loginView.backBtn.isHidden = true
        loginView.nextBtn.isEnabled = false
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loginView.phoneTx
            .rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                if text.count > 0 {
                    if text.count == 10 {
                        view.endEditing(true)
                    }
                    loginView.nextBtn.isEnabled = true
                    loginView.nextBtn.setImage(UIImage(named: "keyiidanjibetn"), for: .normal)
                }else {
                    loginView.nextBtn.isEnabled = false
                    loginView.nextBtn.setImage(UIImage(named: "nextimagebbt"), for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
        
        loginView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let phone = self.loginView.phoneTx.text ?? ""
            let yzmVc = LLYZMViewController()
            yzmVc.phoneStr.accept(phone)
            self.navigationController?.pushViewController(yzmVc, animated: true)
        }).disposed(by: disposeBag)
        locationInfo()
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension LLZCViewController {
    
    private func locationInfo() {
        let location = LLLocationConfig()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        location.startUpdatingLocation { model in
            print("model========:\(model.strongest)====\(dateFormatter.string(from: Date()))")
        }
    }
    
}
