//
//  BookAppointmentView.swift
//  healthcare.au.edu.uts
//
//  Created by Snehasis Sahoo on 10/5/2024.
//

import SwiftUI

import SwiftUI

struct BookAppointmentView: View {
    @ObservedObject var appointmentViewModel: AppointmentViewModel
    @State private var patientName: String = ""
    @State private var clinicAddress: String = ""
    @State private var date = Date()
    @State private var showAlert = false // State variable to control the alert
    @State private var validationMessage = ""
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        Form {
            TextField("Patient Name", text: $patientName)
                .onChange(of: patientName) { newValue in
                    if newValue.isEmpty {
                        validationMessage = "Patient Name cannot be empty"
                    } else if newValue.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil {
                        validationMessage = "Patient Name should contain only alphabets"
                    } else {
                        validationMessage = ""
                    }
                }
            TextField("Clinic Address", text: $clinicAddress)
                .onChange(of: clinicAddress) { newValue in
                    if newValue.isEmpty {
                        validationMessage = "Clinic Address cannot be empty"
                    } else {
                        validationMessage = ""
                    }
                }
            DatePicker("Date", selection: $date, displayedComponents: .date)
            Button("Book Appointment") {
                if validationMessage.isEmpty {
                    appointmentViewModel.bookAppointment(patientName: patientName, clinicAddress: clinicAddress, date: date)
                    showAlert = true // Show the alert
                }
            }
            .disabled(patientName.isEmpty || clinicAddress.isEmpty)
        }
        .navigationTitle("Book Appointment")
        .alert(isPresented: $showAlert) {
            let alertMessage = "Your appointment has been successfully booked."
            return Alert(
                title: Text("Appointment Booked"),
                message: Text(alertMessage + (validationMessage.isEmpty ? "" : "\n\n\(validationMessage)")),
                dismissButton: .default(Text("OK"))
            )
        }
        .overlay(
            Text(validationMessage)
                .foregroundColor(.red)
                .padding(.top, verticalSizeClass == .compact ? 5 : 250),
            alignment: .top
        )
    }
}




struct BookAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        let healthCareDataViewModel = HealthCareDataViewModel()
        let appointmentViewModel = AppointmentViewModel(healthCareDataViewModel: healthCareDataViewModel)
        let isBookingAppointment = Binding<Bool>(get: { false }, set: { _ in })
        
        return BookAppointmentView(appointmentViewModel: appointmentViewModel)
    }
}
