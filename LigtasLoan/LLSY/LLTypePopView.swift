//
//  LLTypePopView.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/27.
//

import UIKit

class PopPhotoView: UIView {
    
    lazy var scro: UIScrollView = {
        let scro = UIScrollView()
        scro.backgroundColor = .white
        scro.showsHorizontalScrollIndicator = false
        scro.showsVerticalScrollIndicator = false
        scro.contentInsetAdjustmentBehavior = .never
        return scro
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.numberOfLines = 0
        mlabel.text = "Please upload the front side of your ID photo."
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_Poppins, size: 14)
        return mlabel
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "canimageb"), for: .normal)
        return backBtn
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "Groumi")
        ctImageView.contentMode = .scaleAspectFill
        return ctImageView
    }()
    
    lazy var ctImageView1: UIImageView = {
        let ctImageView1 = UIImageView()
        ctImageView1.image = UIImage(named: "ambidimage")
        ctImageView1.contentMode = .scaleAspectFill
        return ctImageView1
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitle("ALBUM", for: .normal)
        nextBtn.titleLabel?.font = UIFont(name: Bold_Poppins, size: 18)
        nextBtn.backgroundColor = .white
        nextBtn.layer.borderWidth = 2
        nextBtn.setTitleColor(UIColor.init(cssStr: "#222222"), for: .normal)
        nextBtn.layer.borderColor = UIColor.init(cssStr: "#222222").cgColor
        return nextBtn
    }()
    
    lazy var nextBtn1: UIButton = {
        let nextBtn1 = UIButton(type: .custom)
        nextBtn1.setTitleColor(UIColor.init(cssStr: "#1EFB91"), for: .normal)
        nextBtn1.setTitle("SHOOT", for: .normal)
        nextBtn1.titleLabel?.font = UIFont(name: Bold_Poppins, size: 18)
        nextBtn1.backgroundColor = UIColor.init(cssStr: "#222222")
        return nextBtn1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scro)
        scro.addSubview(mlabel)
        scro.addSubview(backBtn)
        scro.addSubview(ctImageView)
        scro.addSubview(ctImageView1)
        scro.addSubview(nextBtn)
        scro.addSubview(nextBtn1)
        scro.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview()
            make.width.equalTo(sc_width)
            make.top.equalToSuperview().offset(215)
        }
        mlabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(19)
            make.width.equalTo(sc_width - 84)
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.left.equalTo(sc_width - 40)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        ctImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(79)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(sc_width - 30)
            make.height.equalTo(212)
        }
        ctImageView1.snp.makeConstraints { make in
            make.top.equalTo(ctImageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(sc_width - 30)
            make.height.equalTo(106)
        }
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(sc_width - 25)
            make.top.equalTo(ctImageView1.snp.bottom).offset(42)
            make.height.equalTo(56)
        }
        nextBtn1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(sc_width - 25)
            make.top.equalTo(nextBtn.snp.bottom).offset(15)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PopCameraView: UIView {
    
    lazy var scro: UIScrollView = {
        let scro = UIScrollView()
        scro.backgroundColor = .white
        scro.showsHorizontalScrollIndicator = false
        scro.showsVerticalScrollIndicator = false
        scro.contentInsetAdjustmentBehavior = .never
        return scro
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.numberOfLines = 0
        mlabel.text = "Please upload the front side of your ID photo."
        mlabel.textColor = UIColor.init(cssStr: "#000000")
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_Poppins, size: 14)
        return mlabel
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "canimageb"), for: .normal)
        return backBtn
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "Grohellimge")
        ctImageView.contentMode = .scaleAspectFill
        return ctImageView
    }()
    
    lazy var ctImageView1: UIImageView = {
        let ctImageView1 = UIImageView()
        ctImageView1.image = UIImage(named: "Grhellcaim")
        ctImageView1.contentMode = .scaleAspectFill
        return ctImageView1
    }()
    
    lazy var nextBtn1: UIButton = {
        let nextBtn1 = UIButton(type: .custom)
        nextBtn1.setTitleColor(UIColor.init(cssStr: "#1EFB91"), for: .normal)
        nextBtn1.setTitle("UPLOAD", for: .normal)
        nextBtn1.titleLabel?.font = UIFont(name: Bold_Poppins, size: 18)
        nextBtn1.backgroundColor = UIColor.init(cssStr: "#222222")
        return nextBtn1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scro)
        scro.addSubview(mlabel)
        scro.addSubview(backBtn)
        scro.addSubview(ctImageView)
        scro.addSubview(ctImageView1)
        scro.addSubview(nextBtn1)
        scro.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview()
            make.width.equalTo(sc_width)
            make.top.equalToSuperview().offset(295)
        }
        mlabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(19)
            make.width.equalTo(sc_width - 84)
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.left.equalTo(sc_width - 40)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        ctImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(79)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(sc_width - 30)
            make.height.equalTo(212)
        }
        ctImageView1.snp.makeConstraints { make in
            make.top.equalTo(ctImageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(sc_width - 30)
            make.height.equalTo(106)
        }
        nextBtn1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(sc_width - 25)
            make.top.equalTo(ctImageView1.snp.bottom).offset(30)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
