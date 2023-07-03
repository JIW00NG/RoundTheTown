//
//  DefaultMapViewController.swift
//  RoundTheTown
//
//  Created by Lena on 2023/06/20.
//

import UIKit
import CoreLocation

import GoogleMaps

class DefaultMapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: - Properties
    var locationManager: CLLocationManager!
    var latitude: Double = 37.55
    var longitude: Double = 126.98
    
    private var mapView: GMSMapView = {
        // zoom: 확대/축소 수준 표시
        // 우선 서울 위도 경도 값 기준
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 37.57,
                                                                 longitude: 126.98,
                                                                 zoom: 12)

        let mapView = GMSMapView(frame: .zero, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        return mapView
    }()
    // 현위치로 가기 기능 -> 버튼은 활성화했지만 현 위치로 가지를 못함
    // 줌인/줌아웃기능 -> zoomGestures를 true로 설정했지만 왜 안될까?
    // 비교화면 전환 기능
    // 주소검색기능
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
        self.view = mapView
        mapView.delegate = self
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        marker.title = "내 위치"
        marker.map = mapView
    }
    
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let coordinate = locationManager.location?.coordinate
        
        latitude = (coordinate?.latitude ?? 37.55) as Double
        longitude = (coordinate?.longitude ?? 126.99) as Double
        
        print("latitude: \(latitude), longitude: \(longitude)")
    }
}
