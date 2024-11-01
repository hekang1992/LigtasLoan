//
//  LLRequestManager.swift
//  LigtasLoan
//  
//  Created by 何康 on 2024/10/16.
//

import Moya
import SwiftyJSON

class CommonModel {
    var whey: String
    var andmammy: Int
    var preferreda: preferredaModel
    init(json: JSON) {
        self.andmammy = json["andmammy"].intValue
        self.whey = json["whey"].stringValue
        self.preferreda = preferredaModel(json: json["preferreda"])
    }
}

class preferredaModel {
    var ofhurt: String?
    var screamed: String?
    var nothave: nothaveModel?
    var foryou: String?
    var hisgold: hisgoldModel?
    var toremember: torememberModel?
    var unending: [widehallModel]?
    var squatty: String?
    var aquizzical: String?
    var deepseats: String?
    var widehall: [widehallModel]?
    var andfalling: andfallingModel?
    init(json: JSON) {
        self.squatty = json["squatty"].stringValue
        self.aquizzical = json["aquizzical"].stringValue
        self.deepseats = json["deepseats"].stringValue
        self.ofhurt = json["ofhurt"].stringValue
        self.screamed = json["screamed"].stringValue
        self.nothave = nothaveModel(json: json["nothave"])
        self.foryou = json["foryou"].stringValue
        self.hisgold = hisgoldModel(json: json["hisgold"])
        self.toremember = torememberModel(json: json["toremember"])
        self.unending = json["unending"].arrayValue.map {
            widehallModel(json: $0)
        }
        self.widehall = json["widehall"].arrayValue.map {
            widehallModel(json: $0)
        }
        self.andfalling = andfallingModel(json: json["andfalling"])
    }
}

class andfallingModel {
    var unending: [widehallModel]
    init(json: JSON) {
        self.unending = json["unending"].arrayValue.map {
            widehallModel(json: $0)
        }
    }
}

class torememberModel {
    var dully: Int?
    var foryou: String?
    var hearth: String?
    init(json: JSON) {
        self.hearth = json["hearth"].stringValue
        self.dully = json["dully"].intValue
        self.foryou = json["foryou"].stringValue
    }
}

class hisgoldModel {
    var gabbling: String?
    init(json: JSON) {
        self.gabbling = json["gabbling"].stringValue
    }
}

class nothaveModel {
    var elemental: String?
    var aviolence: [aviolenceModel]?
    init(json: JSON) {
        self.elemental = json["elemental"].stringValue
        self.aviolence = json["aviolence"].arrayValue.map {
            aviolenceModel(json: $0)
        }
    }
}

class aviolenceModel {
    var cad: String?
    init(json: JSON) {
        self.cad = json["cad"].stringValue
    }
}

class widehallModel {
    var hatred: String?
    var throwingher: String?
    var andmammy: String? // key
    var underthe: String? // type -- tx -- btn
    var risked: String? // jianpanleixing
    var butshe: String?
    var elemental: String?
    var theirbeauty: [theirbeautyModel]?
    var pic_url: String?
    var cad: String?
    var unending: [widehallModel]?
    var prettiest: String?
    var haddreamed: String?
    var wasempty: String?//key
    var aquizzical: String?//name
    var waslooking: String?//phone
    var losing: [theirbeautyModel]
    var relationText: String?
    init(json: JSON) {
        self.relationText = json["relationText"].stringValue
        self.hatred = json["hatred"].stringValue
        self.throwingher = json["throwingher"].stringValue
        self.andmammy = json["andmammy"].stringValue
        self.underthe = json["underthe"].stringValue
        self.risked = json["risked"].stringValue
        self.butshe = json["butshe"].stringValue
        self.elemental = json["elemental"].stringValue
        self.theirbeauty = json["theirbeauty"].arrayValue.map {
            theirbeautyModel(json: $0)
        }
        self.aquizzical = json["aquizzical"].stringValue
        self.pic_url = json["pic_url"].stringValue
        self.cad = json["cad"].stringValue
        self.unending = json["unending"].arrayValue.map {
            widehallModel(json: $0)
        }
        self.prettiest = json["prettiest"].stringValue
        self.haddreamed = json["haddreamed"].stringValue
        self.wasempty = json["wasempty"].stringValue
        self.waslooking = json["waslooking"].stringValue
        self.losing = json["losing"].arrayValue.map {
            theirbeautyModel(json: $0)
        }
    }
}

class theirbeautyModel {
    var aquizzical: String?
    var elemental: String?
    init(json: JSON) {
        self.aquizzical = json["aquizzical"].stringValue
        self.elemental = json["elemental"].stringValue
    }
}










//==================================================












let BASE_URL = "http://8.220.185.183:8081/llapi"

let H5_URL = "http://8.220.185.183:8081"

enum APIService {
    case requestAPI(params: [String: Any]?, pageUrl: String, method: Moya.Method)
    case uploadImageAPI(params: [String: Any]?, pageUrl: String, data: Data, method: Moya.Method)
    case uploadDataAPI(params: [String: Any]?, pageUrl: String, method: Moya.Method)
}

extension APIService: TargetType {
    var baseURL: URL {
        let baseUrl = RePinJieURL.appendQueryParameters(urlString: BASE_URL, parameters: LLDLInfo.getLogiInfo()) ?? ""
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .requestAPI(_, let pageUrl, _), .uploadImageAPI(_, let pageUrl, _, _), .uploadDataAPI(_, let pageUrl, _):
            return pageUrl
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestAPI(_, _, let method),
                .uploadImageAPI(_, _, _, let method),
                .uploadDataAPI(_, _, let method):
            return method
        }
    }
    
    var task: Task {
        switch self {
        case .requestAPI(let params, _, _):
            return .requestParameters(parameters: params ?? [:], encoding: URLEncoding.default)
            
        case .uploadImageAPI(let params, _, let data, _):
            var formData = [MultipartFormData]()
            formData.append(MultipartFormData(provider: .data(data), name: "tryst", fileName: "tryst.png", mimeType: "image/png"))
            if let params = params {
                for (key, value) in params {
                    if let value = value as? String, let data = value.data(using: .utf8) {
                        formData.append(MultipartFormData(provider: .data(data), name: key))
                    }
                }
            }
            return .uploadMultipart(formData)
            
        case .uploadDataAPI(let params, _, _):
            var formData = [MultipartFormData]()
            if let params = params {
                for (key, value) in params {
                    if let value = value as? String, let data = value.data(using: .utf8) {
                        formData.append(MultipartFormData(provider: .data(data), name: key))
                    }
                }
            }
            return .uploadMultipart(formData)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Connection": "keep-alive",
            "Content-Type": "application/x-www-form-urlencoded;text/javascript;text/json;text/plain;multipart/form-data"
        ]
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

class LLRequestManager: NSObject {
    
    private let provider = MoyaProvider<APIService>()
    
    private func requestData(target: APIService, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try JSON(data: response.data)
                    let CommonModel = CommonModel(json: json)
                    self.handleResponse(CommonModel: CommonModel, completion: completion)
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleResponse(CommonModel: CommonModel, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        let frown = CommonModel.whey
        if CommonModel.andmammy == 0 || CommonModel.andmammy == 00 {
            completion(.success(CommonModel))
        }else if CommonModel.andmammy == -2 {
            let error = NSError(domain: "-2", code: -2)
            completion(.failure(error))
            ToastUtility.showToast(message: frown)
        }else {
            let error = NSError(domain: "-2", code: -2)
            completion(.failure(error))
            ToastUtility.showToast(message: frown)
        }
    }
    
    func requestAPI(params: [String: Any]?, pageUrl: String, method: Moya.Method, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        requestData(target: .requestAPI(params: params, pageUrl: pageUrl, method: method), completion: completion)
    }
    
    func uploadDataAPI(params: [String: Any]?, pageUrl: String, method: Moya.Method, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        requestData(target: .requestAPI(params: params, pageUrl: pageUrl, method: method), completion: completion)
    }
    
    func uploadImageAPI(params: [String: Any]?, pageUrl: String, data: Data, method: Moya.Method, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        requestData(target: .uploadImageAPI(params: params, pageUrl: pageUrl, data: data, method: method), completion: completion)
    }
    
}

class RePinJieURL {
    static  func appendQueryParameters(urlString: String, parameters: [String: String]) -> String? {
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems?.append(contentsOf: queryItems)
        }
        return urlComponents.url?.absoluteString
    }
}
