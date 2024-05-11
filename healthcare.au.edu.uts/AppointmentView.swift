//
//  AppointmentView.swift
//  healthcare.au.edu.uts
//
//  Created by Snehasis Sahoo on 7/5/2024.
//

import SwiftUI

struct AppointmentView: View {
    @ObservedObject var appointmentViewModel: AppointmentViewModel

    var body: some View {
        VStack {
            if let errorMessage = appointmentViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                ScrollView {
                    VStack {
                        ForEach(appointmentViewModel.appointments, id: \.id) { appointment in
                            AppointmentRow(appointment: appointment)
                        }
                        .onDelete { indexSet in
                            // Delete appointments when delete button is tapped
                            indexSet.forEach { index in
                                let appointment = appointmentViewModel.appointments[index]
                                appointmentViewModel.deleteAppointment(id: appointment.id)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            // Fetch appointments when the view appears
            appointmentViewModel.fetchAppointments()
        }
    }
}


struct AppointmentRow: View {
    let appointment: Appointment

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Patient: \(appointment.patientName)")
                Text("Date: \(appointment.date)")
                Text("Clinic Address: \(appointment.clinicAddress)")
            }
            Spacer()
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    // Handle delete action
                    // You can implement your delete logic here if needed
                }
        }
        .padding()
    }
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample appointment view model with dummy data
        let dummyViewModel = AppointmentViewModel(healthCareDataViewModel: HealthCareDataViewModel())
        let dummyAppointments: [Appointment] = [
            Appointment(id: UUID(), patientName: "John Doe", date: Date(), clinicAddress: "123 Main St"),
            Appointment(id: UUID(), patientName: "Jane Smith", date: Date(), clinicAddress: "456 Elm St")
        ]
        dummyViewModel.appointments = dummyAppointments
        
        // Return the preview of AppointmentView with the sample view model
        return AppointmentView(appointmentViewModel: dummyViewModel)
    }
}

