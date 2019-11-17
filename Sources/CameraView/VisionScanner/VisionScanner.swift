//
//  File.swift
//  
//
//  Created by Jacob Martin on 11/16/19.
//

import Combine
import Vision

open class VisionScanner: ObservableObject {
    
    let model: VNCoreMLModel?
    @Published public var capturedResults: [Any] = []
    
    public init(model: VNCoreMLModel? = nil) {
        self.model = model
    }
    
}
