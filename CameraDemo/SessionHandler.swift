//
//  SessionHandler.swift
//  CameraDemo
//
//  Created by Hui Chih Wang on 2021/6/28.
//

import Foundation
import AVFoundation

class SessionHandler {
    
    let session = AVCaptureSession()
    private var sessionQueue = DispatchQueue(label: "capture_session")
    
    init() {
        sessionQueue.async {
            self.setUpSession()
        }
    }
    
    private func setUpSession() {
        session.beginConfiguration()
        
        if let device = AVCaptureDevice.default(for: .video),
           let deviceInput = try? AVCaptureDeviceInput(device: device),
           session.canAddInput(deviceInput) {
            session.addInput(deviceInput)
        }
        
        let photoOutput = AVCapturePhotoOutput()
        if session.canAddOutput(photoOutput) {
            session.sessionPreset = .photo
            session.addOutput(photoOutput)
        }
        
        session.commitConfiguration()
        session.startRunning()
    }
}
