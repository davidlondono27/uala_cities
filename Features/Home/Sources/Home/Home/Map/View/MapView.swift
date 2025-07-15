//
//  MapView.swift
//  Home
//
//  Created by David Londono on 15/07/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import DomainLayer
import MapKit
import SwiftUI
import Theme

struct MapView: View {
    @Binding var city: City?
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $cameraPosition) {
            if let city = city {
                Marker(
                    "\(city.name), \(city.country)",
                    coordinate: CLLocationCoordinate2DMake(
                        city.coordinates.latitude,
                        city.coordinates.longitude
                    )
                )
                Annotation(
                    city.name,
                    coordinate: CLLocationCoordinate2DMake(
                        city.coordinates.latitude,
                        city.coordinates.longitude
                    )
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.ualaBlue)
                        Text("📍")
                            .padding(5)
                    }
                }
            }
        }
        .mapControlVisibility(.hidden)
        .onChange(of: city) { _, newCity in
            updateCameraPosition(for: newCity)
        }
        .onAppear {
            updateCameraPosition(for: city)
        }
    }
    
    private func updateCameraPosition(for city: City?) {
        if let city = city {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: city.coordinates.latitude,
                        longitude: city.coordinates.longitude
                    ),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            )
        }
    }
}
