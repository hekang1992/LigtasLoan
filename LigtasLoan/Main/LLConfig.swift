//
//  LLConfig.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/22.
//

import UIKit
import Lottie
import BRPickerView

let Bold_SFDisplay = "SFDisplay-Semibold"
let Regular_SFDisplay = "SFDisplay-Light"

let ROOT_VC = "ROOT_VC"

var is_login: Bool {
    if let sessionID = UserDefaults.standard.object(forKey: LL_NID) as? String {
        return !sessionID.isEmpty
    } else {
        return false
    }
}

class StatusBarHelper {
    class func getStatusBarHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.statusBarManager?.statusBarFrame.height ?? 0
        }
        return 0
    }
}

extension UIColor {
    convenience init(cssStr: String) {
        var hexString: String = cssStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            self.init(white: 0.0, alpha: 0.0)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

class LLLoadingView: UIView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return bgView
    }()
    
    lazy var hudView: LottieAnimationView = {
        let hudView = LottieAnimationView(name: "juhuajiaz.json", bundle: Bundle.main)
        hudView.backgroundColor = UIColor.init(cssStr: "#D6FBE7").withAlphaComponent(0.6)
        hudView.layer.cornerRadius = 8
        hudView.animationSpeed = 1.5
        hudView.loopMode = .loop
        hudView.play()
        return hudView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(bgView)
        bgView.addSubview(hudView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hudView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 125, height: 125))
        }
    }
    
}

class ViewLoadingManager {
    
    static let loadView = LLLoadingView()
    
    static func addLoadingView() {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first {
                DispatchQueue.main.async {
                    loadView.frame = keyWindow.bounds
                    keyWindow.addSubview(loadView)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            hideLoadingView()
        }
    }
    
    static func hideLoadingView() {
        DispatchQueue.main.async {
            loadView.removeFromSuperview()
        }
    }
    
}


class SanPopConfig {
    static func SanChengArray(dataArr: [Any]) -> [BRProvinceModel] {
        var tempArr1 = [BRProvinceModel]()
        for proviceDic in dataArr {
            guard let proviceDic = proviceDic as? widehallModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.code = proviceDic.cad
            proviceModel.name = proviceDic.aquizzical
            proviceModel.index = dataArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            let cityList = proviceDic.unending ?? proviceDic.unending ?? []
            var tempArr2 = [BRCityModel]()
            for cityDic in cityList {
                let cityModel = BRCityModel()
                cityModel.code = cityDic.cad
                cityModel.name = cityDic.aquizzical
                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
                let areaList = cityDic.unending ?? cityDic.unending ?? []
                var tempArr3 = [BRAreaModel]()
                for areaDic in areaList {
                    let areaModel = BRAreaModel()
                    areaModel.code = areaDic.cad
                    areaModel.name = areaDic.aquizzical
                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
                    tempArr3.append(areaModel)
                }
                cityModel.arealist = tempArr3
                tempArr2.append(cityModel)
            }
            proviceModel.citylist = tempArr2
            tempArr1.append(proviceModel)
        }
        return tempArr1
    }
}

typealias complete = () -> Void

class OneTwoThreePopConfig {
    static func popLastEnum<T: widehallModel>(_ model: BRAddressPickerMode, _ label: UILabel, _ provinces: [BRProvinceModel], _ modelData: T, complete: @escaping complete) {
        let addressPickerView = BRAddressPickerView()
        addressPickerView.title = modelData.hatred ?? ""
        addressPickerView.pickerMode = model
        addressPickerView.selectIndexs = [0, 0, 0]
        addressPickerView.dataSourceArr = provinces
        
        addressPickerView.resultBlock = { province, city, area in
            let addressDetails = self.getAddressDetails(province: province, city: city, area: area)
            if let haddreamed = modelData.haddreamed, !haddreamed.isEmpty {
                modelData.relationText = addressDetails.addressString
                modelData.wasempty = addressDetails.code
            }else {
                modelData.butshe = addressDetails.addressString
                modelData.elemental = addressDetails.code
            }
            label.text = addressDetails.addressString
            label.textColor = UIColor.init(cssStr: "#000000")
            complete()
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: Bold_SFDisplay, size: 18)
        customStyle.selectRowTextColor = UIColor(cssStr: "#000000")
        addressPickerView.pickerStyle = customStyle
        addressPickerView.show()
    }

    private static func getAddressDetails(province: BRProvinceModel?, city: BRCityModel?, area: BRAreaModel?) -> (addressString: String, code: String) {
        let provinceName = province?.name ?? ""
        let cityName = city?.name ?? ""
        let areaName = area?.name ?? ""
        var addressString = ""
        var code = ""
        if !provinceName.isEmpty {
            addressString += provinceName
            code += province?.code ?? ""
            if !cityName.isEmpty {
                addressString += "|\(cityName)"
                code += "|\(city?.code ?? "")"
                
                if !areaName.isEmpty {
                    addressString += "|\(areaName)"
                    code += "|\(area?.code ?? "")"
                }
            }
        }
        return (addressString, code)
    }
}

class OnePopConfig {
    static func getOneDetails(dataSourceArr: [Any]) -> [BRProvinceModel] {
        return dataSourceArr.compactMap { item in
            guard let proviceDic = item as? theirbeautyModel else { return nil }
            let proviceModel = BRProvinceModel()
            proviceModel.name = proviceDic.aquizzical
            proviceModel.code = proviceDic.elemental
            proviceModel.index = dataSourceArr.firstIndex { $0 as AnyObject === proviceDic as AnyObject } ?? 0

            return proviceModel
        }
    }
}

class TPopConfig {
    static func getTDetails(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var tempArr1 = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? theirbeautyModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.name = proviceDic.aquizzical
            proviceModel.code = proviceDic.elemental
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            let cityList = proviceDic.theirbeauty ?? proviceDic.theirbeauty ?? []
            var tempArr2 = [BRCityModel]()
            for cityDic in cityList {
                let cityModel = BRCityModel()
                cityModel.code = cityDic.elemental
                cityModel.name = cityDic.aquizzical
                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
                let areaList = cityDic.theirbeauty ?? cityDic.theirbeauty ?? []
                var tempArr3 = [BRAreaModel]()
                for areaDic in areaList {
                    let areaModel = BRAreaModel()
                    areaModel.code = areaDic.elemental
                    areaModel.name = areaDic.aquizzical
                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
                    tempArr3.append(areaModel)
                }
                cityModel.arealist = tempArr3
                tempArr2.append(cityModel)
            }
            proviceModel.citylist = tempArr2
            tempArr1.append(proviceModel)
        }
        return tempArr1
    }
}
