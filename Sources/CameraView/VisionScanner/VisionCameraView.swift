//
//  File.swift
//  
//
//  Created by Jacob Martin on 11/16/19.
//

import SwiftUI
import AVFoundation

public struct VisionCameraView: UIViewControllerRepresentable {
    
    @ObservedObject public var scanner: VisionScanner
    
    public init(scanner: VisionScanner = VisionScanner()) {
        self.scanner = scanner
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<VisionCameraView>) -> VisionCameraViewController {
        return VisionCameraViewController(context.coordinator)
    }
    
    public func updateUIViewController(_ uiViewController: VisionCameraViewController, context: UIViewControllerRepresentableContext<VisionCameraView>) {}
    
    public class Coordinator: NSObject {
        
        let parent: VisionCameraView
        
        init(_ parent: VisionCameraView) {
            self.parent = parent
        }
    
    }
}
