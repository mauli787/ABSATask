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
    
    func getHexValueFromRGB(redColor : String,greenColor:String,blueColor:String){
        let url = Constant.URLS().BaseURL + "id?rgb=\(redColor),\(greenColor),\(blueColor)"
            let weatherURL = URL(string: url)!
            let weatherResource = Resource<HexModel>(url: weatherURL) { data in
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(HexModel.self, from: data)
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
