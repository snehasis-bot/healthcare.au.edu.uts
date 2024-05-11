//
//  healthcare_au_edu_utsApp.swift
//  healthcare.au.edu.uts
//
//  Created by Snehasis Sahoo on 7/5/2024.
//

import SwiftUI

@main
struct healthcare_au_edu_utsApp: App {
    let healthCareDataViewModel = HealthCareDataViewModel()
    let appointmentViewModel: AppointmentViewModel

    init() {
        appointmentViewModel = AppointmentViewModel(healthCareDataViewModel: healthCareDataViewModel)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(appointmentViewModel: appointmentViewModel)
        }
    }
}
