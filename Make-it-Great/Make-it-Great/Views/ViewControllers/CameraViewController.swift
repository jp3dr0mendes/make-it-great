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
    private var food: Food?
    
    var imageBuffer: CVImageBuffer?
    
    @Binding var classification: String
    @Binding var foods: [Food]
    @Binding var foodType: FoodType
    
    @State var object: String = ""
    
    
    init(classification: Binding<String>, foods: Binding<[Food]>, food: Binding<FoodType>) {
        self._classification = classification
        self._foods = foods
        self._foodType = food
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageClassifier(frame: CVPixelBuffer) {
        
        //CVPixelBuffer
        guard let model_object = try? VNCoreMLModel(for: MyImageClassifier_Test3().model) else {
        //guard let model_object = try? VNCoreMLModel(for: FruitClassifier_V1().model) else {
                    print("Erro ao carregar o modelo")
                    return
                }
        
        var request_object = VNCoreMLRequest(model: model_object){ request, error in
            print(request)
            
            //EXECURTANDO UMA REQUISICAO PARA O MODELO DETERMINAR SE A IMAGEM E UMA FRUTA OU VERDURA
            guard let results = request.results as? [VNClassificationObservation] else {
                return
            }
             guard let classification_object = results.first?.identifier else {
                return
            }
//            self.object = classification_object
            print("passando aqui: \(classification_object) \(self.object)")
//            self.classification = classification_object
            
            //CASO SEJA FRUTA OU VERDURA EXECUTA OUTRA REQUISICAO PARA DETERMINAR QUAL CLASSE REPRESENTA
            if classification_object == "Fruta" {
                guard let model_fruit = try? VNCoreMLModel(for: FruitClassifier_V1().model) else {
                            print("Erro ao carregar o modelo")
                            return
                        }
                
                var request_fruit = VNCoreMLRequest(model: model_fruit){ request, error in
                    print(request)
                    guard let results = request.results as? [VNClassificationObservation] else {
                        return
                    }
                     guard let classification_fruit = results.first?.identifier else {
                        return
                    }
                    
                    self.classification = classification_fruit
                    
                    var detectedFood: Food = Food(nome: self.classification, emoji: "🍎", storage: .refrigerator, type: .Fruta, consumirAte: nil, units: 1, weight: nil)
                    
                    if !self.foods.contains(where: {$0.nome == detectedFood.nome}) {
                        self.foods.append(detectedFood)
                    }
                }
                
                let handler_object = VNImageRequestHandler(cvPixelBuffer: frame)
                
                try! handler_object.perform([request_fruit])
            } else if classification_object == "Verdura" {
                guard let model_veg = try? VNCoreMLModel(for: VegClassifier_1().model) else {
                            print("Erro ao carregar o modelo")
                            return
                        }
                
                var request_veg = VNCoreMLRequest(model: model_veg){ request, error in
                    print(request)
                    guard let results = request.results as? [VNClassificationObservation] else {
                        return
                    }
                     guard let classification_veg = results.first?.identifier else {
                        return
                    }
                    
                    self.classification = classification_veg
                    //aqui
                    
                    var detectedFood: Food = Food(nome: self.classification, emoji: "🥕", storage: .cabinet, type: .Vegetal, consumirAte: nil, units: 1, weight: nil)
                    
                    if !self.foods.contains(where: {$0.nome == detectedFood.nome}) {
                        self.foods.append(detectedFood)
                    }
                    
                }
                
                let handler_object = VNImageRequestHandler(cvPixelBuffer: frame)
                
                try! handler_object.perform([request_veg])
            }
        }
        
        let handler_object = VNImageRequestHandler(cvPixelBuffer: frame)
        
        try! handler_object.perform([request_object])
        
        print("passando aqui")
        
//        if (self.object == "Verdura") || (self.object == "Fruta") {
//            guard let model_fruit = try? VNCoreMLModel(for: FruitClassifier_V1().model) else {
//                        print("Erro ao carregar o modelo")
//                        return
//                    }
//            
//            var request_fruit = VNCoreMLRequest(model: model_fruit){ request, error in
//                print(request)
//                guard let results = request.results as? [VNClassificationObservation] else {
//                    return
//                }
//                 guard let classification_fruit = results.first?.identifier else {
//                    return
//                }
//                
//                self.classification = classification_fruit
//            }
//            
//            let handler_object = VNImageRequestHandler(cvPixelBuffer: frame)
//            
//            try! handler_object.perform([request_fruit])
//        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Solicitar permissão de acesso à câmera
        checkPermissions { error in
                if let error = error {
                    // Lide com o erro (ex.: mostrar um alerta)
                    print(error.localizedDescription)
                } else {
                    // Permissões garantidas e câmera configurada corretamente
                    print("Câmera configurada com sucesso!")
                }
            }
    }
    
    func configureCameraSession() {
        
        //Configuração da sessao da camera...
        captureSession = AVCaptureSession()
        guard let captureSession else { return }
        
        captureSession.beginConfiguration()
        
        //Para escolher a câmera traseira:
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.global().async {
            self.captureSession?.startRunning()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.global().async {
            self.captureSession?.stopRunning()
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
    
    private func checkPermissions(completion: @escaping (Error?) -> ()) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // O usuário ainda não foi solicitado, então pedimos permissão
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    // Permissão concedida, configurar a câmera
                    DispatchQueue.main.async {
                        self?.configureCameraSession()
                    }
                } else {
                    // Permissão negada, lidar com o caso de negação
                    DispatchQueue.main.async {
                        completion(NSError(domain: "CameraAccess", code: 1, userInfo: [NSLocalizedDescriptionKey: "Permissão de acesso à câmera foi negada."]))
                    }
                }
            }
        case .restricted:
            // O acesso à câmera está restrito (ex.: controles parentais)
            DispatchQueue.main.async {
                completion(NSError(domain: "CameraAccess", code: 2, userInfo: [NSLocalizedDescriptionKey: "O acesso à câmera está restrito."]))
            }
        case .denied:
            // O usuário negou anteriormente o acesso à câmera
            DispatchQueue.main.async {
                    self.showCameraAccessDeniedAlert()
                    completion(NSError(domain: "CameraAccess", code: 3, userInfo: [NSLocalizedDescriptionKey: "Permissão de acesso à câmera foi negada anteriormente."]))
                }
        case .authorized:
            // O acesso já foi autorizado, configurar a câmera
            DispatchQueue.main.async {
                self.configureCameraSession()
            }
        @unknown default:
            // Lidar com futuros casos que não são conhecidos na versão atual
            DispatchQueue.main.async {
                completion(NSError(domain: "CameraAccess", code: 4, userInfo: [NSLocalizedDescriptionKey: "Status desconhecido para permissão de câmera."]))
            }
        }
    }
    
    func showCameraAccessDeniedAlert() {
        let alert = UIAlertController(
            title: "Permissão de Câmera Negada",
            message: "O acesso à câmera foi negado. Por favor, permita o acesso à câmera nas configurações para continuar usando essa funcionalidade.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Abrir Configurações", style: .default) { _ in
            // Abre as configurações do app
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        })
        
        // Apresenta o alerta
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

struct CameraView: UIViewControllerRepresentable {
    
    @Binding var classification: String
    @Binding var foods: [Food]
    @Binding var food: FoodType
    
    func makeUIViewController(context: Context) -> CameraViewController{
        return CameraViewController(classification: $classification, foods: $foods, food: $food)
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        //Aqui é para atualizar a view caso precise
    }
}


