//
//  ViewController.swift
//  ABSATask
//
//  Created by Dnyaneshwar on 09/06/21.
//

import UIKit

class ViewController: UIViewController{

    private var rgbViewModel = RGBColorViewModel()
    private var colorVM = ColorViewModel()
    @IBOutlet weak var redTextField: BindableTextField! {
        didSet {
            redTextField.bind { self.colorVM.rColor = $0 }
        }
    }
    @IBOutlet weak var greenTextField: BindableTextField! {
        didSet {
            greenTextField.bind { self.colorVM.gColor = $0 }
        }
    }
    @IBOutlet weak var blueTextField: BindableTextField! {
        didSet {
            blueTextField.bind { self.colorVM.bColor = $0 }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbViewModel.delegate = self
    }
    @IBAction func colorPickerClickActionBUtton(_ sender: UIButton) {
        let picker = UIColorPickerViewController()
        picker.selectedColor = self.view.backgroundColor!
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func getHexValues(_ sender: UIButton) {
        print(colorVM)
        if let red = redTextField.text,let blue = blueTextField.text,let green = greenTextField.text {
         rgbViewModel.getHexValueFromRGB(redColor : red,greenColor:green,blueColor:blue)
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
extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.redTextField.text = viewController.selectedColor.rgba.red.description
        self.greenTextField.text = viewController.selectedColor.rgba.green.description
        self.blueTextField.text = viewController.selectedColor.rgba.blue.description
    }
}

extension ViewController : HexModelDelegate {

    func getHexModel(model: Hex) {
        guard let hexValue = model.value else { return }
        AlertView.showAlert(view:self, title:"Hex Value",message: "\(hexValue)")
    }
}

extension ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
    }
}
