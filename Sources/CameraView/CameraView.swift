import SwiftUI

public struct CameraView: UIViewControllerRepresentable {
    
    public init() {}
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> CameraViewController {
        return CameraViewController()
    }
    
    public func updateUIViewController(_ uiViewController: CameraViewController, context: UIViewControllerRepresentableContext<CameraView>) {
        
    }
}
