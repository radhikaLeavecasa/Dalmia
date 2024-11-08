//
//  UIImagePicker.swift
//  Josh
//
//  Created by Esfera-Macmini on 26/04/22.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import AVFoundation

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?
    
    override init(){
        super.init()
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
          //  self.openCamera((UIImage) -> ())
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback
        self.viewController = viewController

        alert.popoverPresentationController?.sourceView = self.viewController!.view

        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            pickImageCallback = callback
            viewController.present(picker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            viewController.present(alertController, animated: true)
        }
    }
    
    func openSelfieCamera(_ viewController: UIViewController, _ callback: @escaping ((UIImage?) -> Void)) {
        
//        alert.dismiss(animated: true, completion: nil)
//        
//        let cameraVC = CustomCameraViewController()
//        cameraVC.photoCaptureCompletion = callback
//        viewController.present(cameraVC, animated: true, completion: nil)
        
        // Dismiss any existing alert (if applicable)
        alert.dismiss(animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.cameraDevice = .front  // Set to use the front camera
            picker.delegate = self
            picker.showsCameraControls = true
            picker.allowsEditing = false
           
            pickImageCallback = callback
            
            viewController.present(picker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have a camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            viewController.present(alertController, animated: true)
        }
    }
    
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
  
    // For Swift 4.2+
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            guard let image = info[.originalImage] as? UIImage else {
                fatalError("\(AlertMessages.EXPECTED_DICTIONARY_ALERT) \(info)")
            }
            self.pickImageCallback?(image)
        }
    }
}
class CustomCameraViewController: UIViewController {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var photoOutput: AVCapturePhotoOutput!
    
    // Callback to return the captured image
    var photoCaptureCompletion: ((UIImage?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupUI()
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        
        // Use the front camera
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Front camera not available")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            captureSession.addInput(input)
        } catch {
            print("Error setting up front camera: \(error)")
            return
        }
        
        photoOutput = AVCapturePhotoOutput()
        captureSession.addOutput(photoOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    func setupUI() {
        // Add a button to take photo
        let captureButton = UIButton(frame: CGRect(x: (view.frame.width - 70) / 2, y: view.frame.height - 100, width: 65, height: 65))
        captureButton.layer.cornerRadius = 32.5
        captureButton.backgroundColor = .white
        captureButton.setTitle("Capture", for: .normal)
        captureButton.setTitleColor(.black, for: .normal)
        captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        view.addSubview(captureButton)
    }

    @objc func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
}


extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            // Return nil if image creation fails
            photoCaptureCompletion?(nil)
            return
        }
        // Return the captured image
        photoCaptureCompletion?(image)
        dismiss(animated: true, completion: nil)
    }
    
    // Required method to handle potential errors
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            photoCaptureCompletion?(nil)
            dismiss(animated: true, completion: nil)
            return
        }
        
        // If there's no error, process the photo as before
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            photoCaptureCompletion?(nil)
            return
        }
        
        // Return the captured image
        photoCaptureCompletion?(image)
        dismiss(animated: true, completion: nil)
    }
}
