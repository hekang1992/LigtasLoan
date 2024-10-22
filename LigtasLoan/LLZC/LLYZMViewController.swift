//
//  LLYZMViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit

class LLYZMViewController: LLBaseViewController {
    
    lazy var codeView: LLYZMView = {
        let codeView = LLYZMView()
        codeView.sImageView.isHidden = true
        codeView.mlabel.text = "Enter Verification Code"
        codeView.nlabel.text = "Enter your phone number, if not registered, it will be automatically registered."
        return codeView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        codeView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: disposeBag)
        
//        codeView.securityCodeView.complete = { [weak self] code in
//            
//        }
        
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
