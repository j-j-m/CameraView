import SwiftUI
import AVFoundation

public struct MetadataCameraView: UIViewControllerRepresentable {
    
    @ObservedObject public var scanner: MetadataScanner
    
    public init(scanner: MetadataScanner = MetadataScanner()) {
        self.scanner = scanner
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<MetadataCameraView>) -> MetadataCameraViewController {
        return MetadataCameraViewController(context.coordinator)
    }
    
    public func updateUIViewController(_ uiViewController: MetadataCameraViewController, context: UIViewControllerRepresentableContext<MetadataCameraView>) {}
    
    public class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        
        let parent: MetadataCameraView
        
        init(_ parent: MetadataCameraView) {
            self.parent = parent
        }
        
        public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            // Get the first object from the metadataObjects array.
            
            parent.scanner.capturedMetadata = metadataObjects
            
        }
    }
}
