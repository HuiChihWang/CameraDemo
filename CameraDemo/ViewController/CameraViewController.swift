//
//  ViewController.swift
//  CameraDemo
//
//  Created by Hui Chih Wang on 2021/6/28.
//

import UIKit

protocol CameraViewControllerDelegate: AnyObject {
    func didCapturePhoto(_ cameraController: CameraViewController, image: UIImage?)
}

class CameraViewController: UIViewController {
    @IBOutlet weak var preview: VideoPreviewView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var photoButton: UIButton!
    
    private let cameraVM = CameraControlViewModel()
    
    weak var delegate: CameraViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraVM.delegate = self
        preview.videoPreviewLayer.session = cameraVM.session.session
    }
    
    
    @IBAction func capturePhoto(_ sender: Any) {
        cameraVM.capturePhoto()
    }
}

extension CameraViewController: CameraControlViewModelDelegate {
    func willCapturePhoto() {
        DispatchQueue.main.async {
            self.photoButton.isHidden = true
            self.spinner.startAnimating()
            
            self.preview.videoPreviewLayer.opacity = 0
            UIView.animate(withDuration: 0.2) {
                self.preview.videoPreviewLayer.opacity = 1
            }
        }
    }
    
    func didCapturePhoto(image: UIImage?) {
        delegate?.didCapturePhoto(self, image: image)
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.photoButton.isHidden = false
            self.navigationController?.popViewController(animated: true)
        }
    }
}


