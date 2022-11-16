//
//  CityScreenViewController.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import UIKit
import MapKit

protocol CityScreenViewControllerProtocol: AnyObject {
    func didGetError(message: String?)
    func didGetWeather(response: WeatherResponse)
}

class CityScreenViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var cityMapKit: MKMapView!
    @IBOutlet private weak var contentTableView: UITableView!
    
    // MARK: - Constraints
    @IBOutlet weak var cityMapKitHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var presenter: CityScreenPresenterProtocol?
    var oldContentOffset = CGPoint.zero
    private var city: City?
    private var weather: WeatherResponse? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.contentTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseAppearance()
        setupTableContent()
        
        if let city {
            presenter?.neededLoadWeather(coordinate: city.coord)
        }
    }
    
    // MARK: - Public
    func setCity(_ value: City) {
        city = value
    }
}

// MARK: - CityScreenViewControllerProtocol
extension CityScreenViewController: CityScreenViewControllerProtocol {
    func didGetError(message: String?) {
        presentError(message: message)
    }
    
    func didGetWeather(response: WeatherResponse) {
        weather = response
    }
}

// MARK: - Private
private extension CityScreenViewController {
    func setupBaseAppearance() {
        guard let city else { return }
        let mapHeight = UIScreen.main.bounds.height / 3
        
        title = city.name
        zoomToCoordinate(with: .init(latitude: city.coord.lat, longitude: city.coord.lon))
        cityMapKitHeightConstraint.constant = mapHeight
    }
    
    func setupTableContent() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    func zoomToCoordinate(with coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        let anotation = MKPointAnnotation()
        
        anotation.coordinate = coordinate
        cityMapKit.setRegion(region, animated: true)
        cityMapKit.addAnnotation(anotation)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CityScreenViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather != nil ? 6 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard let weather else { return cell }
        
        switch indexPath.item {
            case 0:
                cell.textLabel?.text = weather.weather.first?.description
            case 1:
                cell.textLabel?.text = "Temperature: \(weather.main.temp)°C"
            case 2:
                cell.textLabel?.text = "Temperature Min: \(weather.main.tempMin)°C"
            case 3:
                cell.textLabel?.text = "Temperature Max: \(weather.main.tempMax)°C"
            case 4:
                cell.textLabel?.text = "Humidity: \(weather.main.humidity)%"
            case 5:
                cell.textLabel?.text = "Wind speed: \(weather.wind.speed) meter/sec"
            default:
                break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension CityScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let mapHeight = UIScreen.main.bounds.height / 3
        var headerTransform = CATransform3DIdentity
        let minHeight = view.safeAreaInsets.top
        let yPos = scrollView.contentOffset.y
        let contentOffset =  yPos - oldContentOffset.y

        if contentOffset > 0 && yPos > 0 {
            if (cityMapKitHeightConstraint.constant > minHeight ) {
                cityMapKitHeightConstraint.constant -= contentOffset
                scrollView.contentOffset.y -= contentOffset
            }
        }

        if yPos < -5 {
            if (cityMapKitHeightConstraint.constant < mapHeight) {
                if cityMapKitHeightConstraint.constant - contentOffset > mapHeight {
                    cityMapKitHeightConstraint.constant = mapHeight
                } else {
                    cityMapKitHeightConstraint.constant -= contentOffset
                    scrollView.contentOffset.y -= contentOffset
                }
            }
        }
            
        if yPos < 0 {
            let headerScaleFactor = -yPos / cityMapKit.bounds.height
            let headerSizevariation = ((cityMapKit.bounds.height * (1 + headerScaleFactor)) - cityMapKit.bounds.height) / 2

            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1 + headerScaleFactor, 1 + headerScaleFactor, 0)
        }

        oldContentOffset = scrollView.contentOffset
        cityMapKit.layer.transform = headerTransform
    }
}
