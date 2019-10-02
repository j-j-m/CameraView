import SwiftUI
import AVFoundation

public struct CameraView: UIViewControllerRepresentable {
    
    @Binding public var metadata: AVMetadataObject?
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> CameraViewController {
        return CameraViewController(context.coordinator)
    }
    
    public func updateUIViewController(_ uiViewController: CameraViewController, context: UIViewControllerRepresentableContext<CameraView>) {}
    
    public class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            // Get the first object from the metadataObjects array.
            
            if let meta = metadataObjects.first {
                parent.metadata = meta
            }
            
        }
    }
}
