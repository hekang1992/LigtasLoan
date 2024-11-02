//
//  LLLocationConfig.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/11/2.
//

import CoreLocation
import RxSwift
import RxRelay

class LLLModel: NSObject {
    var tosee : String = ""
    var library : String = ""
    var unfeigned : String = ""
    var thatwas : String = ""
    var battalion: Double = 0.0
    var strongest: Double = 0.0
    var godis : String = ""
}

class LLLocationConfig: NSObject {
    
    private var locationManager = CLLocationManager()
    
    private var locationUpdateHandler: ((_ locationModel :LLLModel) -> Void)?
    
    let disposeBag = DisposeBag()
    
    var model = BehaviorRelay<LLLModel?>(value: nil)
    
    var type: String = "0"
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        model.debounce(RxTimeInterval.milliseconds(400), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { locationModel in
                if let locationModel = locationModel {
                    self.locationUpdateHandler?(locationModel)
                }
            }).disposed(by: disposeBag)
    }
    
    deinit {
        print("disposeBag========disposeBag")
    }
    
}

extension LLLocationConfig: CLLocationManagerDelegate  {
    
    func startUpdatingLocation(completion: @escaping (_ locationModel :LLLModel) -> Void) {
        locationUpdateHandler = completion
        if CLLocationManager.authorizationStatus() == .denied {
            let model = LLLModel()
            locationUpdateHandler?(model)
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            locationManager.stopUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        let model = LLLModel()
        model.strongest = longitude
        model.battalion = latitude
        let geocoder = CLGeocoder()
        let location1 = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location1) { [weak self] placemarks, error in
            guard let self = self, let placemark = placemarks?.first else { return }
            model.tosee = placemark.locality ?? ""
            model.thatwas = (placemark.subLocality ?? "") + (placemark.thoroughfare ?? "")
            model.unfeigned = placemark.country ?? ""
            model.library = placemark.isoCountryCode ?? ""
            model.godis = placemark.administrativeArea ?? ""
            self.model.accept(model)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error============:\(error)")
    }
    
}
