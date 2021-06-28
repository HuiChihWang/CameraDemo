//
//  PhotoCaptureProcessor.swift
//  CameraDemo
//
//  Created by Hui Chih Wang on 2021/6/28.
//

import Foundation
import AVFoundation

class PhotoCaptureProcessor: NSObject, AVCapturePhotoCaptureDelegate {
    private static var processes = [Int64: PhotoCaptureProcessor]()
    
    private var procId: Int64
    private var completion: ((Data?) -> Void)?
    
    init(with captureSetting: AVCapturePhotoSettings,
         completion: ((Data?) -> Void)? = nil) {
        self.procId = captureSetting.uniqueID
        self.completion = completion
        
        super.init()
        PhotoCaptureProcessor.processes[procId] = self
    }
        
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("capture photo in processor")
        let photoData = photo.fileDataRepresentation()
        completion?(photoData)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        print("finish proc with id: \(resolvedSettings.uniqueID)")
        PhotoCaptureProcessor.processes[resolvedSettings.uniqueID] = nil
    }
}
