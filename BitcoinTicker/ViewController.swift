//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Mohamed Abd el Aty on 2/24/20.
//  Copyright © 2020 Aty. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let baseURL = "https://api.coindesk.com/v1/bpi/currentprice/"
    let currencyArray = ["","AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbolArry = ["","$","R$","$","Ÿ","Ề","ℰ","$","Rp","𝒰","𝒵","Ÿ","$","kr","$","zl","lei","𝔓","kr","$","$","R"]
    var finalURL = ""
    var currencySelected = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currencyArray[row]
    }
     
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        finalURL = baseURL + currencyArray[row] + ".json"
        currencySelected = currencySymbolArry[row]
        getBitcoinData(url: finalURL)
        
        
    }
     
    //TODO: Place your 3 UIPickerView delegate methods here
    
    
    

    
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getBitcoinData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                                
                if response.result.isSuccess {

                    let bitcoinJSON : JSON = JSON(response.result.value!)

                    self.updateBitcoinData(json: bitcoinJSON)

                } else {
                    
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateBitcoinData(json: JSON) {
        
        if let bitcoinResult = json["bpi"]["USD"]["rate_float"].double {
        
            bitcoinPriceLabel.text = "\(currencySelected)\(bitcoinResult)"
        
        }
        
        else {
            
            bitcoinPriceLabel.text = "Price Unavailable"
        }
    
    }
    




}

