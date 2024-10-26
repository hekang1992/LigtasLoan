//
//  LLUploadIDViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/27.
//

import UIKit
import RxRelay
import TYAlertController

class UploadView: UIView {
    
    lazy var scro: UIScrollView = {
        let scro = UIScrollView()
        scro.backgroundColor = .init(cssStr: "#F6F7F6")
        scro.showsHorizontalScrollIndicator = false
        scro.showsVerticalScrollIndicator = false
        scro.contentInsetAdjustmentBehavior = .never
        return scro
    }()
    
    lazy var photoView: UIView = {
        let photoView = UIView()
        photoView.backgroundColor = .white
        photoView.layer.cornerRadius = 12
        return photoView
    }()
    
    lazy var typelabel: UILabel = {
        let typelabel = UILabel()
        typelabel.textColor = UIColor.init(cssStr: "#000000")
        typelabel.textAlignment = .left
        typelabel.font = UIFont(name: Bold_Poppins, size: 14)
        return typelabel
    }()
    
    lazy var changeBtn: UIButton = {
        let changeBtn = UIButton(type: .custom)
        changeBtn.setImage(UIImage(named: "changebtim"), for: .normal)
        return changeBtn
    }()
    
    lazy var cBtn: UIButton = {
        let cBtn = UIButton(type: .custom)
        cBtn.setImage(UIImage(named: "typeclikimage"), for: .normal)
        cBtn.adjustsImageWhenHighlighted = false
        return cBtn
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.numberOfLines = 0
        mlabel.text = "Please confirm that it matches the selected document!"
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_Poppins, size: 16)
        return mlabel
    }()
    
    lazy var cameaBtn: UIButton = {
        let cameaBtn = UIButton(type: .custom)
        cameaBtn.setImage(UIImage(named: "Grocame"), for: .normal)
        cameaBtn.adjustsImageWhenHighlighted = false
        return cameaBtn
    }()
    
    lazy var mlabel1: UILabel = {
        let mlabel1 = UILabel()
        mlabel1.numberOfLines = 0
        mlabel1.text = "Please ensure good lighting, maintain a natural expression, and remain relatively still!"
        mlabel1.textColor = UIColor.init(cssStr: "#000000")
        mlabel1.textAlignment = .left
        mlabel1.font = UIFont(name: Bold_Poppins, size: 16)
        return mlabel1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scro)
        scro.addSubview(photoView)
        photoView.addSubview(typelabel)
        photoView.addSubview(changeBtn)
        photoView.addSubview(cBtn)
        scro.addSubview(mlabel)
        scro.addSubview(cameaBtn)
        scro.addSubview(mlabel1)
        
        scro.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        photoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(260)
            make.width.equalTo(sc_width - 30)
        }
        typelabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(17)
        }
        changeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(typelabel.snp.centerY)
            make.size.equalTo(CGSize(width: 24, height: 24))
            make.right.equalToSuperview().offset(-12)
        }
        cBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.left.right.equalToSuperview()
            make.height.equalTo(212)
        }
        mlabel.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(sc_width - 50)
        }
        cameaBtn.snp.makeConstraints { make in
            make.top.equalTo(mlabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(212)
            make.width.equalTo(sc_width - 30)
        }
        mlabel1.snp.makeConstraints { make in
            make.top.equalTo(cameaBtn.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(sc_width - 50)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





class LLUploadIDViewController: LLBaseViewController {
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.mlabel.text = "ID VERIFICATION"
        return headView
    }()
    
    lazy var uploadView: UploadView = {
        let uploadView = UploadView()
        return uploadView
    }()
    
    var type = BehaviorRelay<String>(value: "")
    
    var lo = BehaviorRelay<String>(value: "")
    
    lazy var pop1: PopPhotoView = {
        let pop1 = PopPhotoView(frame: self.view.bounds)
        return pop1
    }()
    
    lazy var pop2: PopCameraView = {
        let pop2 = PopCameraView(frame: self.view.bounds)
        return pop2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(headView)
        view.addSubview(uploadView)
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(StatusBarHelper.getStatusBarHeight() + 56)
        }
        uploadView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
        headView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.pushlistvc()
        }).disposed(by: disposeBag)
        
        uploadView.typelabel.text = type.value
        
        uploadView.changeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        
        uploadView.cBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            idPinfo()
        }).disposed(by: disposeBag)
        
        uploadView.cameaBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            cacInfo()
        }).disposed(by: disposeBag)
        
    }

}


extension LLUploadIDViewController {
    
    private func idPinfo() {
        let alertVc = TYAlertController(alert: self.pop1, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        self.pop1.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func cacInfo() {
        let alertVc = TYAlertController(alert: self.pop2, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        self.pop2.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
    
}
