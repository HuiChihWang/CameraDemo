//
//  DisplayViewController.swift
//  CameraDemo
//
//  Created by Hui Chih Wang on 2021/6/28.
//

import UIKit

class DisplayViewController: UIViewController {
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private let displayVM = DisplayViewControlViewModel()
    private let captureSequeId = "capturePhoto"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayVM.delegate = self
        displayVM.checkAuthorization()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == captureSequeId, let controller = segue.destination as? CameraViewController {
            controller.delegate = self
        }
    }
}


extension DisplayViewController: DisplayViewControlViewModelDelegate {
    func didWarningStatusChanged(status: WarningMessage) {
        DispatchQueue.main.async {
            self.warningLabel.text = status.rawValue
        }
    }
}

extension DisplayViewController: CameraViewControllerDelegate {
    func didCapturePhoto(_ cameraController: CameraViewController, image: UIImage?) {
        self.displayVM.isImageTaken = true
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    
}
