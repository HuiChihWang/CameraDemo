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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        warningLabel.text = isImageTaken ? "" : "Please take image"
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
                    self.photoButton.isEnabled = isAllowed
                    self.warningLabel.text = "Please Turn on Your Camera Access"
                }
            }
        }
        
        self.photoButton.isEnabled = authStatus == .authorized
        if authStatus == .denied {
            self.warningLabel.text = "Please Turn on Your Camera Access"
        }
    }
    

}
