//
//  DisplayViewController.swift
//  CameraDemo
//
//  Created by Hui Chih Wang on 2021/6/28.
//

import UIKit
import AVFoundation

class DisplayViewController: UIViewController {

    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let captureSequeId = "capturePhoto"
    let cameraAccessWarning = "Please Turn on Your Camera Access"
    let takePhotoWarning = "Please Take Photo"
    
    private enum WarningStatus {
        case none
        case notAuth
        case noImage
    }
    
    private var warningStatus: WarningStatus = .none {
        didSet {
            switch warningStatus {
            case .notAuth:
                warningLabel.text = cameraAccessWarning
                photoButton.isEnabled = false
            case .noImage:
                warningLabel.text = takePhotoWarning
                photoButton.isEnabled = true
            default:
                warningLabel.text = ""
                photoButton.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if warningStatus != .notAuth, !isImageTaken {
            warningStatus = .noImage
        }
    }
    
    var isImageTaken: Bool {
        return imageView.image != nil
    }
    
    private func checkAuthorization() {
        photoButton.isEnabled = false
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        if authStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { isAllowed in
                DispatchQueue.main.async {
                    self.warningStatus = isAllowed ? .none : .notAuth
                    if self.warningStatus == .none, !self.isImageTaken {
                        self.warningStatus = .noImage
                    }
                }
            }
        }

        if authStatus == .denied {
            warningStatus = .notAuth
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == captureSequeId, let controller = segue.destination as? CameraViewController {
            controller.delegate = self
        }
    }
}




extension DisplayViewController: CameraViewControllerDelegate {
    func didCapturePhoto(_ cameraController: CameraViewController, image: UIImage?) {
        DispatchQueue.main.async {
            self.imageView.image = image
            self.warningStatus = .none
        }
    }
    
    
}
