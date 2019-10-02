//
//  File.swift
//  
//
//  Created by Jacob Martin on 10/1/19.
//

import Combine
import AVFoundation

public class Scanner: ObservableObject {
    
    @Published public var capturedMetadata: [AVMetadataObject] = []
    
}
