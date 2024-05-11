//
//  BookAppointmentView.swift
//  healthcare.au.edu.uts
//
//  Created by Snehasis Sahoo on 10/5/2024.
//

import SwiftUI

struct BookAppointmentView: View {
    @ObservedObject var appointmentViewModel: AppointmentViewModel
    @State private var patientName: String = ""
    @State private var clinicAddress: String = ""
    @State private var date = Date()
    @Binding var isBookingAppointment: Bool
    @State private var showAlert = false // State variable to control the alert
    
    var body: some View {
        Form {
            TextField("Patient Name", text: $patientName)
            TextField("Clinic Address", text: $clinicAddress)
            DatePicker("Date", selection: $date, displayedComponents: .date)
            Button("Book Appointment") {
                appointmentViewModel.bookAppointment(patientName: patientName, clinicAddress: clinicAddress, date: date)
                // Set isBookingAppointment to false to navigate back to AppointmentView
                isBookingAppointment = false
                showAlert = true // Show the alert
            }
        }
        .navigationTitle("Book Appointment")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Appointment Booked"),
                message: Text("Your appointment has been successfully booked."),
                primaryButton: .default(
                    Text("OK"),
                    action: {
                        // Handle OK button action if needed
                    }
                ),
                secondaryButton: .cancel()
            )
        }
    }
}


struct BookAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        let healthCareDataViewModel = HealthCareDataViewModel()
        let appointmentViewModel = AppointmentViewModel(healthCareDataViewModel: healthCareDataViewModel)
        let isBookingAppointment = Binding<Bool>(get: { false }, set: { _ in })
        
        return BookAppointmentView(appointmentViewModel: appointmentViewModel, isBookingAppointment: isBookingAppointment)
    }
}
