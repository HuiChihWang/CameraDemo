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
    func willCapturePhoto()
    func didCapturePhoto(image: UIImage?)
}

class CameraControlViewModel {
    let session = SessionHandler()
    
    weak var delegate: CameraControlViewModelDelegate?
    
    func capturePhoto() {
        session.capturePhoto(
            beforeCapture: {
                self.delegate?.willCapturePhoto()
            }, completion: { photoData in
                if let data = photoData {
                    print("[CameraVM]: Get photo data")
                    let image = UIImage(data: data)
                    self.delegate?.didCapturePhoto(image: image)
                }
            }
        )
    }
}
