//
//  RGBColorViewModel.swift
//  ABSATask
//
//  Created by Dnyaneshwar on 09/06/21.
//

import UIKit


protocol HexModelDelegate {
    func getHexModel(model:Hex)
}
 
struct RGBColorViewModel {
     
    var delegate: HexModelDelegate?
    
    var rColor: String?
    var gColor: String?
    var bColor: String?
    
    func getHexValueFromRGB(redColor : String,greenColor:String,blueColor:String){
        let url = Constant.URLS().BaseURL + "id?rgb=\(redColor),\(greenColor),\(blueColor)"
        print(url)
            let weatherURL = URL(string: url)!
            let weatherResource = Resource<ColorValue>(url: weatherURL) { data in
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(ColorValue.self, from: data)
            return responseModel
        }
        APIManager().loadWebAPI(resource: weatherResource) { [] result in
            guard let vm = result?.hex else { return }
            DispatchQueue.main.async {
                self.delegate?.getHexModel(model: vm)
            }
        }
    }
}
