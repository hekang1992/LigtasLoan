//
//  LLConfig.swift
//  LigtasLoan
//
//  Created by LigtasLoan on 2024/10/22.
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

class LoadingManager {
    
    static let loadView = LLLoadingView()
    
    static func addLoadingView() {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        DispatchQueue.main.async {
            loadView.frame = keyWindow.bounds
            if !keyWindow.subviews.contains(loadView) {
                keyWindow.addSubview(loadView)
            }
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
        return dataArr.compactMap { proviceDic in
            guard let proviceDic = proviceDic as? widehallModel else { return nil }
            let proviceModel = BRProvinceModel()
            proviceModel.code = proviceDic.cad
            proviceModel.name = proviceDic.aquizzical
            proviceModel.index = dataArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            let cityList = proviceDic.unending ?? []
            proviceModel.citylist = cityList.compactMap { cityDic in
                let cityModel = BRCityModel()
                cityModel.code = cityDic.cad
                cityModel.name = cityDic.aquizzical
                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
                let areaList = cityDic.unending ?? []
                cityModel.arealist = areaList.compactMap { areaDic in
                    let areaModel = BRAreaModel()
                    areaModel.code = areaDic.cad
                    areaModel.name = areaDic.aquizzical
                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
                    return areaModel
                }
                return cityModel
            }
            return proviceModel
        }
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
        return dataSourceArr.enumerated().compactMap { (index, item) in
            guard let province = item as? theirbeautyModel else { return nil }
            let provinceModel = BRProvinceModel()
            provinceModel.name = province.aquizzical
            provinceModel.code = province.elemental
            provinceModel.index = index
            return provinceModel
        }
    }
}

class TPopConfig {
    static func getTDetails(dataSourceArr: [Any]) -> [BRProvinceModel] {
        return dataSourceArr.compactMap { proviceDic in
            guard let proviceDic = proviceDic as? theirbeautyModel else {
                return nil
            }
            let proviceModel = BRProvinceModel()
            proviceModel.name = proviceDic.aquizzical
            proviceModel.code = proviceDic.elemental
            proviceModel.index = dataSourceArr.enumerated().first { $0.element as? theirbeautyModel === proviceDic }?.offset ?? 0
            
            // 城市列表
            proviceModel.citylist = proviceDic.theirbeauty?.compactMap { cityDic in
                createCityModel(from: cityDic, in: proviceDic.theirbeauty ?? [])
            } ?? []
            
            return proviceModel
        }
    }

    private static func createCityModel(from cityDic: theirbeautyModel, in cityList: [theirbeautyModel]) -> BRCityModel {
        let cityModel = BRCityModel()
        cityModel.name = cityDic.aquizzical
        cityModel.code = cityDic.elemental
        cityModel.index = cityList.enumerated().first { $0.element === cityDic }?.offset ?? 0
        
        cityModel.arealist = cityDic.theirbeauty?.compactMap { areaDic in
            createAreaModel(from: areaDic, in: cityDic.theirbeauty ?? [])
        } ?? []
        
        return cityModel
    }
    
    private static func createAreaModel(from areaDic: theirbeautyModel, in areaList: [theirbeautyModel]) -> BRAreaModel {
        let areaModel = BRAreaModel()
        areaModel.name = areaDic.aquizzical
        areaModel.code = areaDic.elemental
        
        areaModel.index = areaList.enumerated().first { $0.element === areaDic }?.offset ?? 0
        
        return areaModel
    }
}
