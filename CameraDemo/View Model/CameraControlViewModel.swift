//
//  CameraControlViewModel.swift
//  CameraDemo
//
//  Created by Hui Chih Wang on 2021/6/29.
//

import Foundation
import UIKit
import AVFoundation

protocol CameraControlViewModelDelegate: AnyObject {
    func didCapturePhoto(image: UIImage?)
}

class CameraControlViewModel {
    let session = SessionHandler()
    
    weak var delegate: CameraControlViewModelDelegate?
    
    func capturePhoto() {
        session.capturePhoto { photoData in
            if let data = photoData {
                let image = UIImage(data: data)
                print("get photo data")
                self.delegate?.didCapturePhoto(image: image)
            }
        }
    }
}
