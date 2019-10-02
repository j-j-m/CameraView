import SwiftUI
import AVFoundation

public struct CameraView: UIViewControllerRepresentable {
    
    public class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            // Get the first object from the metadataObjects array.
                   
                   if let barcodeData = metadataObjects.first {
                       
                       // Turn it into machine readable code
                       
                       let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject;
                       
                       if let readableCode = barcodeReadable?.stringValue {
                           
                           // Send the barcode as a string to barcodeDetected()
                           
//                           barcodeDetected(code: readableCode);
                        print("Barcode Detected \(readableCode)")
                       }
                       
                       // Vibrate the device to give the user some feedback.
                       
                       AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                       

                   }
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> CameraViewController {
        return CameraViewController(context.coordinator)
    }
    
    public func updateUIViewController(_ uiViewController: CameraViewController, context: UIViewControllerRepresentableContext<CameraView>) {}
}
