//
//  LLSYViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit
import GYSide

class LLSYViewController: LLBaseViewController {
    
    lazy var oneView: OneView = {
        let oneView = OneView()
        return oneView
    }()
    
    lazy var twoView: TwoView = {
        let twoView = TwoView()
        return twoView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oneView.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.rightVc()
        }).disposed(by: disposeBag)
        
        oneView.ctImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { _ in 
            ToastUtility.showToast(message: "2")
        }).disposed(by: disposeBag)
    
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

extension LLSYViewController {
    
    private func rightVc() {
        let vc = LLRightViewController()
        gy_showSide({ (config) in
            config.direction = .right
            config.animationType = .translationMask
        }, vc)
    }
}
