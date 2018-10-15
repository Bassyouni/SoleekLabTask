//
//  CountriesVC.swift
//  SoleeklabTask
//
//  Created by MacBook Pro on 10/15/18.
//  Copyright © 2018 Bassyouni. All rights reserved.
//

import UIKit

class CountriesVC: ParentViewController {
    
    //MARK:- variables
    var countries = [Country]()

    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- viewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoading()

        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getCountrysDataFromApi {
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideLoading()
            }
        }
    }
    
    //MARK:- IBActions
    @IBAction func logOutPressed(_ sender: Any) {
        UserAuthentication.logOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- functions
    fileprivate func getCountrysDataFromApi(completed: @escaping () -> ())
    {
        let urlString = "https://restcountries.eu/rest/v2/all"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data, error == nil else {
                self.showErrorAlert(message: error!.localizedDescription)
                completed()
                return
            }
            self.countries = Country.parseCountrysData(data: data)
            completed()
        }.resume()
    }

}

//MARK:- tableView Delegate
extension CountriesVC: UITableViewDelegate
{
    
}

//MARK:- tableview DataSource
extension CountriesVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "countriesTabelViewCell", for: indexPath) as? countriesTabelViewCell
        {
            cell.configureCell(country: countries[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}
