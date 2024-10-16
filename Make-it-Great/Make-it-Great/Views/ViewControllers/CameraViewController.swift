//
//  CameraViewController.swift
//  Make-it-Great
//
//  Created by Daniel Barros on 03/10/24.
//

import SwiftUI
import AVFoundation
import CoreML
import Vision
import UIKit

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
//    var image: UIImage?
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var previewFrame: CVPixelBuffer?
    var imageBuffer: CVImageBuffer?
    
    @Binding var classification: String
    
    init(classification: Binding<String>) {
        self._classification = classification
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageClassifier(frame: CVPixelBuffer) {
        //CVPixelBuffer
        guard let model = try? VNCoreMLModel(for: MyImageClassifier_Test3().model) else {
                    print("Erro ao carregar o modelo")
                    return
                }
        
        var request = VNCoreMLRequest(model: model){ request, error in
            print(request)
            guard let results = request.results as? [VNClassificationObservation] else {
                return
            }
             guard let classification = results.first?.identifier else {
                return
            }
            
            self.classification = classification
        }
        
        
        
        let handler = VNImageRequestHandler(cvPixelBuffer: frame)
        
        try! handler.perform([request])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configuração da sessao da camera...
        captureSession = AVCaptureSession()
        guard let captureSession else { return }
        
        captureSession.beginConfiguration()
        
        //Para escolher a câmera traseira:
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        
        if captureSession.canAddInput(videoDeviceInput) {
            captureSession.addInput(videoDeviceInput)
        }
        
        captureSession.commitConfiguration()
        
        //desenvolver a logica de classificar a imagem com base no create ml
        
        //Configura o preview para mostrar a camera na tela:
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = view.bounds
        
        
        let videoCaptureOutput = AVCaptureVideoDataOutput()
        videoCaptureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        captureSession.addOutput(videoCaptureOutput)
        
        videoCaptureOutput.videoSettings = [
            (kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA

        ]
        

//        self.imageBuffer = imageBuffer

        
        if let previewLayer {
            view.layer.addSublayer(previewLayer)
        }
        
        //Começa a capturar:
        DispatchQueue.global().async {
            captureSession.startRunning()
            print("aqui")
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        imageClassifier(frame: frame)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
        
        
//        imageClassifier(image: previewLayer?.frame)
    }
}

struct CameraView: UIViewControllerRepresentable {
    
    @Binding var classification: String
    
    func makeUIViewController(context: Context) -> CameraViewController{
        print("sldkfsd")
        return CameraViewController(classification: $classification)
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        //Aqui é para atualizar a view caso precise
    }
}


