import SwiftUI


struct ContentView: View {
    @ObservedObject var appointmentViewModel: AppointmentViewModel
    @State private var isBookingAppointment = false

    var body: some View {
        NavigationView {
            VStack {
                if isBookingAppointment {
                    BookAppointmentView(appointmentViewModel: appointmentViewModel, isBookingAppointment: $isBookingAppointment)
                } else {
                    NavigationLink(destination: AppointmentView(appointmentViewModel: appointmentViewModel)) {
                        Text("View Appointments")
                    }
                }
            }
            .navigationTitle("Appointments")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isBookingAppointment.toggle()
                    }) {
                        Image(systemName: "calendar.badge.plus")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let healthCareDataViewModel = HealthCareDataViewModel()
        let appointmentViewModel = AppointmentViewModel(healthCareDataViewModel: healthCareDataViewModel)
        
        return ContentView(appointmentViewModel: appointmentViewModel)
    }
}
