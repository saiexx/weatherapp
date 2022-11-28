//
//  ForecastViewController.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 28/11/22.
//

import UIKit
import RxSwift

class ForecastViewController: UIViewController, AlertAble {
    
    var viewModel: ForecastViewModel!
    
    private let disposeBag = DisposeBag()
    private var forecastListDataSource: [DailyForecast] = []
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var forecastTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        subscribeToViewModel()
    }
    
    private func setUpUI() {
        titleLabel.text = "Weather Forecast For \(viewModel.getCityName())"
        
        forecastTableView.register(UINib(nibName: "ForecastTableViewCell", bundle: .main), forCellReuseIdentifier: "ForecastTableViewCell")
        forecastTableView.dataSource = self
        forecastTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func subscribeToViewModel() {
        viewModel.forecastSubject.subscribe { forecast in
            if let forecast = forecast.element {
                if let forecastList = forecast?.list {
                    self.forecastListDataSource = forecastList
                    self.forecastTableView.reloadData()
                }
            }
        }.disposed(by: disposeBag)
        
        viewModel.alertSubject.subscribe { errorMessage in
            self.showAlert(title: errorMessage, message: "Please try again later")
        }.disposed(by: disposeBag)
    }
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastListDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        cell.setCell(data: forecastListDataSource[indexPath.row])
        return cell
    }
}
