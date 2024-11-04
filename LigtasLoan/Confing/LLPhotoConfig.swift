//
//  LLPhotoConfig.swift
//  LigtasLoan
//
//  Created by 何康 on 2024/10/27.
//

import UIKit
import AVFoundation
import Photos

class PLAPhotoManager: NSObject {
    
    static let shared = PLAPhotoManager()
    
    private override init() {
        super.init()
    }
    
    func checkPhotoLibraryPermissions(completion: @escaping (Bool) -> Void) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            completion(true)
        case .limited:
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    completion(status == .authorized)
                }
            }
        case .restricted, .denied:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    func checkCameraPermissions(completion: @escaping (Bool) -> Void) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .restricted, .denied:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    func presentPhoto(from viewController: UIViewController) {
        checkPhotoLibraryPermissions { [weak self] granted in
            guard granted else {
                self?.showSettingsAlert(from: viewController, for: "Photo Album")
                return
            }
            self?.showImagePicker(from: viewController, sourceType: .photoLibrary, isfront: "")
        }
    }
    
    func presentCamera(from viewController: UIViewController, isfront: String) {
        checkCameraPermissions { [weak self] granted in
            guard granted else {
                self?.showSettingsAlert(from: viewController, for: "Camera")
                return
            }
            self?.showImagePicker(from: viewController, sourceType: .camera, isfront: isfront)
        }
    }
    
    private func showImagePicker(from viewController: UIViewController, sourceType: UIImagePickerController.SourceType, isfront: String) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        if sourceType == .camera {
            if isfront == "1" {
                imagePicker.cameraDevice = .front
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.hideCameraton(in: imagePicker.view)
                }
            }else {
                imagePicker.cameraDevice = .rear
            }
        }
        imagePicker.delegate = viewController as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    private func showSettingsAlert(from viewController: UIViewController, for feature: String) {
        let alert = UIAlertController(
            title: "\(feature) Access has been disabled",
            message: "Please enable it in settings \(feature) Permission to use this feature",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Setting", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private func hideCameraton(in view: UIView) {
        for subview in view.subviews {
            if let button = subview as? UIButton, button.description.contains("CAMFlipButton") {
                button.isHidden = true
            } else {
                hideCameraton(in: subview)
            }
        }
    }
}

extension Data {
    static func imageQuality(image: UIImage, maxLength: Int) -> Data? {
        var compression: CGFloat = 0.8
        var data = image.jpegData(compressionQuality: compression)
        if let imageData = data, imageData.count < maxLength {
            return imageData
        }
        var min: CGFloat = 0.0
        var max: CGFloat = 0.9
        let targetSize = Int(Double(maxLength) * 0.7)
        for _ in 0..<5 {
            compression = (max + min) / 2
            if let imageData = image.jpegData(compressionQuality: compression) {
                if imageData.count < targetSize {
                    min = compression
                } else if imageData.count > maxLength {
                    max = compression
                } else {
                    return imageData
                }
                data = imageData
            }
        }
        return data
    }
}

