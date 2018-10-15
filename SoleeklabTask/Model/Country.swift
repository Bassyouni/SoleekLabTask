//
//  Country.swift
//  SoleeklabTask
//
//  Created by MacBook Pro on 10/15/18.
//  Copyright © 2018 Bassyouni. All rights reserved.
//

import Foundation

struct Country {
    var name: String
    
    static func parseCountrysData(data: Data) -> [Country]
    {
        var countryArray = [Country]()
        
        do
        {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let dictArray = jsonArray as? [Dictionary<String,AnyObject>]
            {
                for dict in dictArray
                {
                    if let name = dict["name"] as? String
                    {
                        let country = Country(name: name)
                        countryArray.append(country)
                    }
                }
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        
        return countryArray
    }
}
