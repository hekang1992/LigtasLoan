//
//  HomeView.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/25.
//

let sc_width = UIScreen.main.bounds.size.width
let sc_height = UIScreen.main.bounds.size.height

class OneView: UIView {
    
    lazy var scro: UIScrollView = {
        let scro = UIScrollView()
        scro.backgroundColor = .white
        scro.showsHorizontalScrollIndicator = false
        scro.contentInsetAdjustmentBehavior = .never
        return scro
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "homeonbg")
        ctImageView.contentMode = .scaleAspectFill
        ctImageView.isUserInteractionEnabled = true
        return ctImageView
    }()
    
    lazy var mlabel0: UILabel = {
        let mlabel0 = UILabel()
        mlabel0.text = "How to apply?"
        mlabel0.textColor = UIColor.init(cssStr: "#000000")
        mlabel0.textAlignment = .left
        mlabel0.font = UIFont(name: Bold_Poppins, size: 14)
        return mlabel0
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "1.Continuously make timely payments to demonstrate your reliability and creditworthiness."
        mlabel.numberOfLines = 0
        mlabel.textColor = UIColor.init(cssStr: "#000000").withAlphaComponent(0.5)
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_Poppins, size: 12)
        return mlabel
    }()
    
    lazy var mlabel1: UILabel = {
        let mlabel1 = UILabel()
        mlabel1.text = "2.Update your income information with your credit provider to demonstrate your increased earning potential."
        mlabel1.numberOfLines = 0
        mlabel1.textColor = UIColor.init(cssStr: "#000000").withAlphaComponent(0.5)
        mlabel1.textAlignment = .left
        mlabel1.font = UIFont(name: Bold_Poppins, size: 12)
        return mlabel1
    }()
    
    lazy var mlabel2: UILabel = {
        let mlabel2 = UILabel()
        mlabel2.text = "How to make a repayment?"
        mlabel2.textColor = UIColor.init(cssStr: "#000000")
        mlabel2.textAlignment = .left
        mlabel2.font = UIFont(name: Bold_Poppins, size: 14)
        return mlabel2
    }()
    
    lazy var ctImageView1: UIImageView = {
        let ctImageView1 = UIImageView()
        ctImageView1.image = UIImage(named: "Downimge")
        ctImageView1.contentMode = .scaleAspectFit
        return ctImageView1
    }()
    
    lazy var ctImageView2: UIImageView = {
        let ctImageView2 = UIImageView()
        ctImageView2.image = UIImage(named: "Downimge")
        ctImageView2.contentMode = .scaleAspectFit
        return ctImageView2
    }()
    
    lazy var mlabel3: UILabel = {
        let mlabel = UILabel()
        mlabel.text = "1.A stable work history can make you appear more reliable in the eyes of lenders."
        mlabel.numberOfLines = 0
        mlabel.textColor = UIColor.init(cssStr: "#000000").withAlphaComponent(0.5)
        mlabel.textAlignment = .left
        mlabel.font = UIFont(name: Bold_Poppins, size: 12)
        return mlabel
    }()
    
    lazy var mlabel4: UILabel = {
        let mlabel1 = UILabel()
        mlabel1.text = "2.A higher income can improve your financial standing, making you eligible for more favorable interest rates."
        mlabel1.numberOfLines = 0
        mlabel1.textColor = UIColor.init(cssStr: "#000000").withAlphaComponent(0.5)
        mlabel1.textAlignment = .left
        mlabel1.font = UIFont(name: Bold_Poppins, size: 12)
        return mlabel1
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        return rightBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scro)
        scro.addSubview(ctImageView)
        ctImageView.addSubview(rightBtn)
        ctImageView.addSubview(mlabel0)
        scro.addSubview(mlabel)
        scro.addSubview(mlabel1)
        scro.addSubview(mlabel2)
        scro.addSubview(ctImageView1)
        scro.addSubview(ctImageView2)
        scro.addSubview(mlabel3)
        scro.addSubview(mlabel4)
        scro.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        ctImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(sc_width)
            make.height.equalTo(613)
        }
        mlabel0.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.bottom.equalTo(ctImageView.snp.bottom)
        }
        mlabel.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(ctImageView.snp.bottom).offset(9)
        }
        mlabel1.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(mlabel.snp.bottom).offset(12)
        }
        mlabel2.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(mlabel1.snp.bottom).offset(30)
        }
        ctImageView1.snp.makeConstraints { make in
            make.right.equalTo(ctImageView.snp.right).offset(-32)
            make.centerY.equalTo(mlabel2.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        ctImageView2.snp.makeConstraints { make in
            make.right.equalTo(ctImageView.snp.right).offset(-32)
            make.centerY.equalTo(mlabel0.snp.centerY)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        mlabel3.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(mlabel2.snp.bottom).offset(9)
        }
        mlabel4.snp.makeConstraints { make in
            make.width.equalTo(sc_width - 64)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(mlabel3.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-40)
        }
        rightBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.right.equalToSuperview().offset(-13)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TwoView: UIView {
    
}
