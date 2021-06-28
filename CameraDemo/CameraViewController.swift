//
//  ViewController.swift
//  CameraDemo
//
//  Created by Hui Chih Wang on 2021/6/28.
//

import UIKit
import AVFoundation

protocol CameraViewControllerDelegate: AnyObject {
    func didCapturePhoto(_ cameraController: CameraViewController, image: UIImage?)
}

class CameraViewController: UIViewController {
    @IBOutlet weak var preview: VideoPreviewView!
    
    private let sessionHandler = SessionHandler()
    
    weak var delegate: CameraViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preview.videoPreviewLayer.session = sessionHandler.session
    }
    
    
    @IBAction func capturePhoto(_ sender: Any) {
        sessionHandler.capturePhoto { data in
            if let data = data {
                let image = UIImage(data: data)
                self.delegate?.didCapturePhoto(self, image: image)
                print("get photo data")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}


