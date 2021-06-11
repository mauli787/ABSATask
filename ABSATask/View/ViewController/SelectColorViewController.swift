//
//  ViewController.swift
//  ABSATask
//
//  Created by Dnyaneshwar on 09/06/21.
//

import UIKit

class SelectColorViewController: UIViewController{

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
        self.showIndicatorView()
        if let red = redTextField.text,let blue = blueTextField.text,let green = greenTextField.text {
         rgbViewModel.getHexValueFromRGB(redColor : red,greenColor:green,blueColor:blue)
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
extension SelectColorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.redTextField.text = viewController.selectedColor.rgba.red.description
        self.greenTextField.text = viewController.selectedColor.rgba.green.description
        self.blueTextField.text = viewController.selectedColor.rgba.blue.description
        colorPicker.dismiss(animated: true)
    }
}
extension SelectColorViewController : HexModelDelegate {
    func getHexModel(model: Hex) {
        self.hideIndicatorView()
        guard let hexValue = model.value else { return }
        AlertView.showAlert(view:self, title:"Hex Value",message: "\(hexValue)")
    }
}
extension SelectColorViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        print(image)
    }
}
