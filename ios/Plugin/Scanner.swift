//
//  Scanner.swift
//  plugin_dataScanner
//
//  Created by Scott Harrison on 2/20/23.
//

import Foundation
import VisionKit
import SwiftUI

@available(iOS 16.0, *)
@objc(Scanner)
class Scanner : NSObject {

    
    @MainActor var myCon : DataScannerViewController
    @MainActor static var myCoordinator: Coordinator = Coordinator()
    @MainActor static var myScannerHolder: scannerHolder = scannerHolder()
    
    @MainActor @objc override init() {
        self.myCon = DataScannerViewController(recognizedDataTypes:[])
    }
    
    
    @MainActor @objc func makeUIViewController(_ isHighFrameRateTrackingEnabled: Bool, isHighlightingEnabled:Bool, recognizesMultipleItems:Bool, supportBarCode:Bool, supportText:Bool) ->UIViewController {
        var dataType: Set<DataScannerViewController.RecognizedDataType> = [];
        if(supportBarCode){
            dataType.insert(.barcode())
        }
        if(supportText){
            dataType.insert(.text())
        }
        self.myCon = DataScannerViewController(
            recognizedDataTypes: dataType,
            qualityLevel: .balanced,
            recognizesMultipleItems: recognizesMultipleItems,
            isHighFrameRateTrackingEnabled: isHighFrameRateTrackingEnabled,
            isHighlightingEnabled: isHighlightingEnabled)
        self.myCon.delegate = Scanner.myCoordinator
        self.myCon.isModalInPresentation = true
        self.myCon.presentationController?.delegate = Scanner.myCoordinator
        
        return self.myCon
    }
    @MainActor @objc func startScanning(){
        try? self.myCon.startScanning()
    }
    @MainActor @objc func stopScanning(){
        self.myCon.stopScanning()
    }
    
    class Coordinator: UIViewController, DataScannerViewControllerDelegate,UIAdaptivePresentationControllerDelegate {
            
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
                case .text(let text):
                    myScannerHolder.gotText(text.transcript)
                case .barcode(let code):
                    myScannerHolder.gotBarcode(code.payloadStringValue)
                default:
                    break
            }
        }
        
        
        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            myScannerHolder.closeDataScanner()
        }
        
    }
}

/// Delegate methods for `DataScannerViewController`
