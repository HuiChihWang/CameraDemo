//
//  displayViewControlModel.swift
//  CameraDemo
//
//  Created by Hui Chih Wang on 2021/6/29.
//

import Foundation
import AVFoundation

protocol DisplayViewControlViewModelDelegate: AnyObject {
    func didWarningStatusChanged(status: WarningMessage)
}

enum WarningMessage: String {
    case none = ""
    case notAuth = "Please Turn on Your Camera Access"
    case noImage = "Please Take Photo"
}

class DisplayViewControlViewModel {
    
    weak var delegate: DisplayViewControlViewModelDelegate?
    
    private var warningStatus = WarningMessage.none {
        didSet {
            delegate?.didWarningStatusChanged(status: warningStatus)
        }
    }
    
    var isImageTaken = false {
        didSet {
            if isImageTaken {
                warningStatus = .none
            }
        }
    }
    
    func checkAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { isAllowed in
                self.warningStatus = isAllowed ? .none : .notAuth
                if self.warningStatus == .none, !self.isImageTaken {
                    self.warningStatus = .noImage
                }
            }
        case .authorized:
            self.warningStatus = isImageTaken ? .none : .noImage
        default:
            self.warningStatus = .notAuth
        }
    }
}
