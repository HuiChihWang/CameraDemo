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
    private let photoOutput = AVCapturePhotoOutput()
    
    
    init() {
        sessionQueue.async {
            self.setUpSession()
        }
    }
    
    deinit {
        session.stopRunning()
    }
    
    func capturePhoto(completion: @escaping (Data?) -> Void) {
        sessionQueue.async {
            var captureSetting = AVCapturePhotoSettings()
            
            if self.photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                captureSetting = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
            }
            
            captureSetting.flashMode = .auto
            let photoProcessor = PhotoCaptureProcessor(with: captureSetting, completion: completion)
            
            self.photoOutput.capturePhoto(with: captureSetting, delegate: photoProcessor)
            
        }
    }
    
    private func setUpSession() {
        session.beginConfiguration()
        
        if let device = AVCaptureDevice.default(for: .video),
           let deviceInput = try? AVCaptureDeviceInput(device: device),
           session.canAddInput(deviceInput) {
            session.addInput(deviceInput)
        }
        
        if session.canAddOutput(photoOutput) {
            session.sessionPreset = .photo
            session.addOutput(photoOutput)
        }
        
        session.commitConfiguration()
        session.startRunning()
    }
    
}
