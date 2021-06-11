//
//  ViewController.swift
//  ABSATask
//
//  Created by Dnyaneshwar on 09/06/21.
//

import UIKit

class RGBColorViewController: UIViewController{
    
    private var rgbViewModel = RGBColorViewModel()
    let colorPicker = UIColorPickerViewController()
    var activityIndicatorView: ActivityIndicatorView!
    
    @IBOutlet weak var redTextField: BindableTextField! {
        didSet {
            redTextField.bind { self.rgbViewModel.rColor = $0 }
        }
    }
    @IBOutlet weak var greenTextField: BindableTextField! {
        didSet {
            greenTextField.bind { self.rgbViewModel.gColor = $0 }
        }
    }
    @IBOutlet weak var blueTextField: BindableTextField! {
        didSet {
            blueTextField.bind { self.rgbViewModel.bColor = $0 }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbViewModel.delegate = self
    }
    
    @IBAction func colorPickerClickActionBUtton(_ sender: UIButton) {
        colorPicker.selectedColor = self.view.backgroundColor!
        colorPicker.delegate = self
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    @IBAction func getHexValues(_ sender: UIButton) {
        if  redTextField.text?.isEmpty ?? true {
            AlertView.showAlert(view:self, title:"ABSA",message: "Red color Field Should not be empty.")
        }else if blueTextField.text?.isEmpty ?? true {
            AlertView.showAlert(view:self, title:"ABSA",message: "Blue color Field Should not be empty.")
        }else if greenTextField.text?.isEmpty ?? true {
            AlertView.showAlert(view:self, title:"ABSA",message: "Green color Field Should not be empty.")
        }else{
            self.showIndicatorView()
            rgbViewModel.getHexValueFromRGB(redColor: rgbViewModel.rColor!, greenColor: rgbViewModel.gColor!, blueColor: rgbViewModel.bColor!)
        }
    }
    
    func showIndicatorView(){
        DispatchQueue.main.async {
            self.activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: self.view.center)
            self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func hideIndicatorView(){
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    @IBAction func cameraOpenButtonClickAction(_ sender: UIBarButtonItem) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension RGBColorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.redTextField.text = viewController.selectedColor.rgba.red.description
        self.greenTextField.text = viewController.selectedColor.rgba.green.description
        self.blueTextField.text = viewController.selectedColor.rgba.blue.description
        self.redTextField.textFieldChange(self.redTextField)
        self.blueTextField.textFieldChange(self.blueTextField)
        self.greenTextField.textFieldChange(self.greenTextField)
        colorPicker.dismiss(animated: true)
    }
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.redTextField.text = ""
        self.greenTextField.text = ""
        self.blueTextField.text = ""
    }
}

extension RGBColorViewController : HexModelDelegate {
    func getHexModel(model: Hex) {
        self.hideIndicatorView()
        guard let hexValue = model.value else { return }
        AlertView.showAlert(view:self, title:"Hex Value",message: "\(hexValue)")
    }
}

extension RGBColorViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        print(image)
    }
}
