//
//  CameraViewController.swift
//  
//
//  Created by Jacob Martin on 10/1/19.
//

import UIKit
import AVFoundation

public class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a session object.
        
        session = AVCaptureSession()
        
        // Set the capture device and create input object..
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video),
        let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice)
        else {
            return
        }
        
        // Create input object.
    
        
        // Add input to the session.
        
        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            scanningNotPossible()
        }
        
        // Create output object.
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        // Add output to the session.
        
        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)
            
            // Send captured data to the delegate object via a serial queue.
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            
            // Set barcode type for which to scan: EAN-13.
            
            metadataOutput.metadataObjectTypes = [
                .upce,
                .ean13,
                .qr,
                .aztec,
                .code128
            ]
            
        } else {
            scanningNotPossible()
        }
        
        // Add previewLayer and have it show the video data.
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // Begin the capture session.
        
        session.startRunning()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (session?.isRunning == false) {
            session.startRunning()
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (session?.isRunning == true) {
            session.stopRunning()
        }
    }
    
    func scanningNotPossible() {
        
        // Let the user know that scanning isn't possible with the current device.
        
        let alert = UIAlertController(title: "Can't Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        session = nil
    }
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Get the first object from the metadataObjects array.
        
        if let barcodeData = metadataObjects.first {
            
            // Turn it into machine readable code
            
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject;
            
            if let readableCode = barcodeReadable?.stringValue {
                
                // Send the barcode as a string to barcodeDetected()
                
                barcodeDetected(code: readableCode);
            }
            
            // Vibrate the device to give the user some feedback.
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            // Avoid a very buzzy device.
            
            session.stopRunning()
        }
    }
    
    func barcodeDetected(code: String) {
        
        // Let the user know we've found something.
        
        let alert = UIAlertController(title: "Found a Barcode!", message: code, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Search", style: .destructive, handler: { action in
            
            // Remove the spaces.
            
            let trimmedCode = code.trimmingCharacters(in: .whitespaces)
            
            // EAN or UPC?
            // Check for added "0" at beginning of code.
            
            let trimmedCodeString = "\(trimmedCode)"
            var trimmedCodeNoZero: String
            
            if trimmedCodeString.hasPrefix("0") && trimmedCodeString.count > 1 {
                trimmedCodeNoZero = String(trimmedCodeString.dropFirst())
                print("found upc \(trimmedCodeNoZero)")
                // Send the doctored UPC to DataService.searchAPI()
                
//                DataService.searchAPI(trimmedCodeNoZero)
            } else {
                
                // Send the doctored EAN to DataService.searchAPI()
                print("found ean \(trimmedCodeString)")
//                DataService.searchAPI(trimmedCodeString)
            }
            
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
