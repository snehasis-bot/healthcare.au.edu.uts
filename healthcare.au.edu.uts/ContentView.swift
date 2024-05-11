import SwiftUI


import SwiftUI

struct ContentView: View {
    @ObservedObject var appointmentViewModel: AppointmentViewModel
    @State private var isBookingAppointment = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the Healthcare Booking App")
                    .font(.title)
                    .padding()

                
                Spacer()
                
                HStack {
                    NavigationLink(destination: ContentView(appointmentViewModel: appointmentViewModel)) {
                        Image(systemName: "house")
                            .font(.title)
                            .padding()
                    }
                    
                    
                    NavigationLink(destination: BookAppointmentView(appointmentViewModel: appointmentViewModel, isBookingAppointment: $isBookingAppointment)) {
                        Image(systemName: "calendar.badge.plus")
                            .font(.title)
                            .padding()
                    }
                    
                    NavigationLink(destination: AppointmentView(appointmentViewModel: appointmentViewModel)) {
                        Image(systemName: "list.bullet")
                            .font(.title)
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("HBA")
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
