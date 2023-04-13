//
//  ViewController.swift
//  Weather
//
//  Created by Kamil Początek on 07/04/2023.
//

import UIKit

class ResultsViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// TODO: Add no search result handler func
class SelectCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, OpenWeatherManagerDelegate {

    let tableViewCellReuseID = "TableViewCellReuseIdentifier"
    let showWeatherSegueID = "showWeather"

    var tableView: UITableView!
    var weatherModel: WeatherModel?
    var searchController: UISearchController!
    var openWeatherManager = OpenWeatherManager()

    // TODO: Extrack data, use city id instead name
    var allCitiesList = ["Warszawa", "Berlin", "London", "Bali", "Tokyo"]
    var filtedCitiesList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search City"
        
        let resultsViewController = ResultsViewController()

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellReuseID)
        resultsViewController.view.addSubview(tableView)
        
        openWeatherManager.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtedCitiesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseID, for: indexPath)
        cell.textLabel?.text = filtedCitiesList[indexPath.row]
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
            filtedCitiesList = allCitiesList.filter { $0.lowercased().contains(searchText) }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // TODO: Add handle error func
        openWeatherManager.getWeather(cityName: filtedCitiesList[indexPath.row])
    }
    
    func updateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherModel = weather
            self.performSegue(withIdentifier: self.showWeatherSegueID, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == showWeatherSegueID) {
            let showWeatherViewController = segue.destination as! ShowWeatherViewController
            showWeatherViewController.weatherModel = weatherModel
        }
    }
}
