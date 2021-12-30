//
//  MyMapView.swift
//  Map_SwiftUI
//
//  Created by SeongMinK on 2021/12/30.
//

import SwiftUI
import MapKit
import CoreLocation

struct MyMapView: UIViewRepresentable {
    let locationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        print(#fileID, #function, "called")
        
        let mkMapView = MKMapView()
        let resionRadius: CLLocationDistance = 200
        let coordinateResion = MKCoordinateRegion(center: mkMapView.userLocation.coordinate, latitudinalMeters: resionRadius, longitudinalMeters: resionRadius)
        
        mkMapView.delegate = context.coordinator
        mkMapView.showsUserLocation = true
        mkMapView.setUserTrackingMode(.follow, animated: true)
        mkMapView.setRegion(coordinateResion, animated: true)
        
        self.locationManager.delegate = context.coordinator
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print(#fileID, #function, "called")
    }
    
    func makeCoordinator() -> MyMapView.Coordinator {
        return MyMapView.Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var myMapView: MyMapView // SwiftUI View
        init(_ myMapView: MyMapView) {
            self.myMapView = myMapView
        }
    }
}

extension MyMapView.Coordinator: MKMapViewDelegate {
    
}

extension MyMapView.Coordinator: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lat = locations.first?.coordinate.latitude,
              let long = locations.first?.coordinate.longitude else {
            return
        }
        print("didUpdateLocations - 위도: \(lat), 경도: \(long)")
    }
}
