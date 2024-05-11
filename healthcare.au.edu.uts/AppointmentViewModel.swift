//
//  AppointmentViewModel.swift
//  healthcare.au.edu.uts
//
//  Created by Snehasis Sahoo on 7/5/2024.
//

import Foundation
import CoreData

class AppointmentViewModel: ObservableObject {
    // Injecting the instance of HealthCareDataViewModel
    let healthCareDataViewModel: HealthCareDataViewModel
    
    @Published var appointments: [Appointment] = []
    @Published var errorMessage: String?

    // Initializing with an instance of HealthCareDataViewModel
    init(healthCareDataViewModel: HealthCareDataViewModel) {
        self.healthCareDataViewModel = healthCareDataViewModel
    }

    // Function to book appointment
    func bookAppointment(patientName: String, clinicAddress: String, date: Date) {
        // Create AppointmentEntity and save it to CoreData
        let context = healthCareDataViewModel.container.viewContext
        let newAppointment = AppointmentEntity(context: context)
        newAppointment.objectID // Accessing objectID to avoid 'id' error
        newAppointment.patientName = patientName
        newAppointment.clinicAddress = clinicAddress
        newAppointment.date = date

        do {
            try context.save()
            fetchAppointments() // Refresh appointments after booking
        } catch {
            errorMessage = "Failed to book appointment."
        }
    }

    // Function to fetch appointments
    func fetchAppointments() {
        let request: NSFetchRequest<AppointmentEntity> = AppointmentEntity.fetchRequest()
        do {
            // Fetch appointments from Core Data
            let appointmentsFromCoreData = try healthCareDataViewModel.container.viewContext.fetch(request)
            // Convert fetched AppointmentEntity objects to Appointment objects
            appointments = appointmentsFromCoreData.compactMap { appointmentEntity in
                if let id = appointmentEntity.appointmentID {
                    let appointment = Appointment(id: id, patientName: appointmentEntity.patientName ?? "", date: appointmentEntity.date ?? Date(), clinicAddress: appointmentEntity.clinicAddress ?? "")
                    print("Fetched Appointment: \(appointment)")
                    return appointment
                }
                // Handle error case where conversion fails
                return nil
            }
            errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch appointments: \(error.localizedDescription)"
            print(errorMessage ?? "Unknown error occurred while fetching appointments")
        }
    }


}
