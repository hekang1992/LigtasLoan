//
//  LLUploadIDViewController.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/27.
//

import UIKit
import RxRelay
import TYAlertController
import BRPickerView

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
        typelabel.font = UIFont(name: Bold_SFDisplay, size: 14)
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
        mlabel.font = UIFont(name: Bold_SFDisplay, size: 16)
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
        mlabel1.font = UIFont(name: Bold_SFDisplay, size: 16)
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




//+++++++++++++++++++++++++++++++++++++++++++++++++++++










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
    
    lazy var pop1: PopPhotoView = {
        let pop1 = PopPhotoView(frame: self.view.bounds)
        return pop1
    }()
    
    lazy var pop2: PopCameraView = {
        let pop2 = PopCameraView(frame: self.view.bounds)
        return pop2
    }()
    
    var type = BehaviorRelay<String>(value: "")
    
    var lo = BehaviorRelay<String>(value: "")
    
    var isFace = BehaviorRelay<String>(value: "0")
    
    
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
        
        huoimquid(from: lo.value)
    }
    
}


extension LLUploadIDViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func idPinfo() {
        let alertVc = TYAlertController(alert: self.pop1, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        self.pop1.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        self.pop1.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                PLAPhotoManager.shared.presentPhoto(from: self)
            }
        }).disposed(by: disposeBag)
        
        self.pop1.nextBtn1.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                self.isFace.accept("0")
                PLAPhotoManager.shared.presentCamera(from: self, isfront: "0")
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func cacInfo() {
        let alertVc = TYAlertController(alert: self.pop2, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        self.pop2.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        self.pop2.nextBtn1.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                self.isFace.accept("1")
                PLAPhotoManager.shared.presentCamera(from: self, isfront: "1")
            }
        }).disposed(by: disposeBag)
    }
    
    func huoimquid(from proid: String) {
        let man = LLRequestManager()
        ViewLoadingManager.addLoadingView()
        man.requestAPI(params: ["lo": proid, "recallanything": "happy"], pageUrl: "/ll/sitting/troop/affection", method: .get) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                let model = success.preferreda
                if let dully = model.toremember?.dully, let self = self {
                    if dully == 0 {
                        self.uploadView.cBtn.isEnabled = true
                        self.uploadView.cameaBtn.isEnabled = false
                    }else {
                        self.uploadView.cBtn.kf.setImage(with: URL(string: model.toremember?.foryou ?? ""), for: .normal)
                        self.uploadView.typelabel.text = model.toremember?.hearth ?? ""
                        self.uploadView.changeBtn.isHidden = true
                        self.uploadView.cBtn.isEnabled = false
                        self.uploadView.cameaBtn.isEnabled = true
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        if let data = Data.imageQuality(image: image, maxLength: 1024) {
            picker.dismiss(animated: true) { [weak self] in
                DispatchQueue.main.async {
                    self?.upimageData(from: data, image: image)
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func upimageData(from data: Data, image: UIImage) {
        var imageDict: [String: String]
        imageDict = ["numbers": "1",
                     "precepts": "1",
                     "lo": lo.value,
                     "hearth": type.value,
                     "chosen": "",
                     "depressed": "1"]
        if self.isFace.value == "0" {
            let dict = ["elemental": "11"]
            imageDict.merge(dict) { (_, new) in new }
        }else {
            let dict = ["elemental": "10"]
            imageDict.merge(dict) { (_, new) in new }
        }
        ViewLoadingManager.addLoadingView()
        let man = LLRequestManager()
        man.uploadImageAPI(params: imageDict, pageUrl: "/ll/rough/handful/spoke", data: data, method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            switch result {
            case .success(let success):
                if let self = self {
                    if self.isFace.value == "0" {
                        self.popnameIDView(from: success.preferreda)
                    }else {
                        self.pageinDetailInfo(from: lo.value)
                    }
                }
                break
            case .failure(_):
                break
            }
        }
        
    }
    
    // shenfenxinxi----pop
    func popnameIDView(from model: preferredaModel) {
        let nameIDView = PopNameIDCardView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: nameIDView, preferredStyle: .actionSheet)
        nameIDView.model = model
        self.present(alertVc!, animated: true)
        nameIDView.backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        
        nameIDView.name1.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            settitme(form: nameIDView, clickBtn: nameIDView.name1.nextBtn)
        }).disposed(by: disposeBag)
        
        nameIDView.nextBtn1.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.bcnameInfo(form: nameIDView)
        }).disposed(by: disposeBag)
        
    }
    
    private func bcnameInfo(form view: PopNameIDCardView) {
        ViewLoadingManager.addLoadingView()
        let dict = ["deepseats": view.name1.nextBtn.titleLabel?.text ?? "", "aquizzical": view.name2.inputtx.text ?? "", "squatty": view.name3.inputtx.text ?? "", "elemental": "11", "hearth": type.value]
        let man = LLRequestManager()
        man.requestAPI(params: dict, pageUrl: "/ll/girlsas/trouble/mother", method: .post) { [weak self] result in
            ViewLoadingManager.hideLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.dismiss(animated: true) {
                    self.huoimquid(from: self.lo.value)
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func settitme(form view: PopNameIDCardView, clickBtn: UIButton) {
        let timeStr = clickBtn.titleLabel?.text ?? "01-01-1900"
        let timeArray = timeStr.components(separatedBy: "-")
        
        guard timeArray.count == 3,
              let day = Int(timeArray[0]),
              let month = Int(timeArray[1]),
              let year = Int(timeArray[2]) else {
            return
        }
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = "Date"
        datePickerView.minDate = NSDate.br_setYear(1900, month: 01, day: 01)
        datePickerView.selectDate = NSDate.br_setYear(year, month: month, day: day)
        datePickerView.maxDate = Date()
        
        datePickerView.resultBlock = { selectDate, selectValue in
            guard let selectValue = selectValue else { return }
            let selectedArray = selectValue.components(separatedBy: "-")
            
            if selectedArray.count == 3 {
                let selectedDay = selectedArray[2]
                let selectedMonth = selectedArray[1]
                let selectedYear = selectedArray[0]
                clickBtn.setTitle("\(selectedDay)-\(selectedMonth)-\(selectedYear)", for: .normal)
            }
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: Bold_SFDisplay, size: 18) ?? UIFont.systemFont(ofSize: 18)
        customStyle.selectRowTextColor = UIColor(cssStr: "#000000")
        datePickerView.pickerStyle = customStyle
        datePickerView.show()
    }
    
}
