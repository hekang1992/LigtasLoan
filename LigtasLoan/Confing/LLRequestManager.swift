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
    var consternation: hisgoldModel?
    var herplacid: herplacidModel?
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
        self.consternation = hisgoldModel(json: json["consternation"])
        self.unending = json["unending"].arrayValue.map {
            widehallModel(json: $0)
        }
        self.widehall = json["widehall"].arrayValue.map {
            widehallModel(json: $0)
        }
        self.andfalling = andfallingModel(json: json["andfalling"])
        self.herplacid = herplacidModel(json: json["herplacid"])
    }
}

class herplacidModel {
    var aviolence: [aviolenceModel]
    init(json: JSON) {
        self.aviolence = json["aviolence"].arrayValue.map {
            aviolenceModel(json: $0)
        }
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
    var trembling: String?
    init(json: JSON) {
        self.gabbling = json["gabbling"].stringValue
        self.trembling = json["trembling"].stringValue
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
    var foryou: String?
    var caring: String?
    var blot: String?
    var thenyou: String?
    var itseemed: String?
    var toanyone: String?
    var makeyou: String?
    init(json: JSON) {
        self.cad = json["cad"].stringValue
        self.foryou = json["foryou"].stringValue
        self.caring = json["caring"].stringValue
        self.blot = json["blot"].stringValue
        self.thenyou = json["thenyou"].stringValue
        self.itseemed = json["itseemed"].stringValue
        self.makeyou = json["makeyou"].stringValue
        self.toanyone = json["toanyone"].stringValue
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
    var widehall: [widehallModel]?
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
        self.widehall = json["widehall"].arrayValue.map {
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
    var triumphedasherealize: String?
    var theirbeauty: [theirbeautyModel]?
    init(json: JSON) {
        self.aquizzical = json["aquizzical"].stringValue
        self.elemental = json["elemental"].stringValue
        self.triumphedasherealize = json["triumphedasherealize"].stringValue
        self.theirbeauty = json["theirbeauty"].arrayValue.map {
            theirbeautyModel(json: $0)
        }
    }
}










//==================================================





let base_URL = "http://8.220.185.183:8081/llapi"

let h5_URL = "http://8.220.185.183:8081"

enum APIService {
    case request(params: [String: Any]?, pageURL: String, method: Moya.Method)
    case uploadImage(params: [String: Any]?, pageURL: String, imageData: Data, method: Moya.Method)
    case uploadData(params: [String: Any]?, pageURL: String, method: Moya.Method)
}

extension APIService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: base_URL) else { fatalError("Invalid base URL") }
        let extendedURL = LLJieURL.appendters(url: url.absoluteString, parameters: LLDLInfo.getLogiInfo()) ?? ""
        return URL(string: extendedURL)!
    }
    
    var path: String {
        switch self {
        case .request(_, let pageURL, _), .uploadImage(_, let pageURL, _, _), .uploadData(_, let pageURL, _):
            return pageURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .request(_, _, let method),
             .uploadImage(_, _, _, let method),
             .uploadData(_, _, let method):
            return method
        }
    }
    
    var task: Task {
        switch self {
        case .request(let params, _, _):
            return .requestParameters(parameters: params ?? [:], encoding: URLEncoding.default)
            
        case .uploadImage(let params, _, let imageData, _):
            return .uploadMultipart(createMultipartFormData(params: params, imageData: imageData))
            
        case .uploadData(let params, _, _):
            return .uploadMultipart(createMultipartFormData(params: params))
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
    
    private func createMultipartFormData(params: [String: Any]?, imageData: Data? = nil) -> [MultipartFormData] {
        var formData = [MultipartFormData]()
        
        if let imageData = imageData {
            formData.append(MultipartFormData(provider: .data(imageData), name: "tryst", fileName: "tryst.png", mimeType: "image/png"))
        }
        
        params?.forEach { key, value in
            if let stringValue = value as? String, let data = stringValue.data(using: .utf8) {
                formData.append(MultipartFormData(provider: .data(data), name: key))
            }
        }
        
        return formData
    }
}

class LLRequestManager: NSObject {
    private let provider = MoyaProvider<APIService>()
    
    private func requestData(target: APIService, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                self.handleResponse(response, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleResponse(_ response: Response, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        do {
            let json = try JSON(data: response.data)
            let commonModel = CommonModel(json: json)
            if commonModel.andmammy == 0 {
                completion(.success(commonModel))
            } else {
                ToastUtility.showToast(message: commonModel.whey)
                throw createError(from: commonModel)
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    private func createError(from commonModel: CommonModel) -> Error {
        let errorDescription = commonModel.whey
        return NSError(domain: "APIError", code: commonModel.andmammy, userInfo: [NSLocalizedDescriptionKey: errorDescription])
    }
    
    func requestAPI(params: [String: Any]?, pageURL: String, method: Moya.Method, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        requestData(target: .request(params: params, pageURL: pageURL, method: method), completion: completion)
    }
    
    func uploadDataAPI(params: [String: Any]?, pageURL: String, method: Moya.Method, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        requestData(target: .uploadData(params: params, pageURL: pageURL, method: method), completion: completion)
    }
    
    func uploadImageAPI(params: [String: Any]?, pageURL: String, imageData: Data, method: Moya.Method, completion: @escaping (Result<CommonModel, Error>) -> Void) {
        requestData(target: .uploadImage(params: params, pageURL: pageURL, imageData: imageData, method: method), completion: completion)
    }
}

class LLJieURL {
    static func appendters(url: String, parameters: [String: String]) -> String? {
        guard var urlComponents = URLComponents(string: url) else {
            return nil
        }
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        return urlComponents.url?.absoluteString
    }
}



