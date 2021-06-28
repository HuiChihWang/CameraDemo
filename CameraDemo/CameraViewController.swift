//
//  ViewController.swift
//  CameraDemo
//
//  Created by Hui Chih Wang on 2021/6/28.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    @IBOutlet weak var preview: VideoPreviewView!
    
    private let sessionHandler = SessionHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preview.videoPreviewLayer.session = sessionHandler.session
    }
    
    
    @IBAction func capturePhoto(_ sender: Any) {
        sessionHandler.capturePhoto()
    }
    
    
    
    
}

