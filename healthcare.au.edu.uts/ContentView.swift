
import SwiftUI

struct ContentView: View {
    @ObservedObject var appointmentViewModel: AppointmentViewModel
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            VStack {
                if selectedTab == 0 {
                    HomeView()
                } else if selectedTab == 1 {
                    BookAppointmentView(appointmentViewModel: appointmentViewModel)
                } else {
                    AppointmentView(appointmentViewModel: appointmentViewModel)
                }
                Spacer()
                navButtons
            }
            .navigationBarTitle("HBA")
        }
    }

    var navButtons: some View {
        HStack {
            Spacer()
            
            Button(action: { selectedTab = 0 }) {
                Image(systemName: "house")
                    .font(.system(size: 28))
            }
            .padding(.trailing, 20)
            
            Spacer()
            
            Button(action: { selectedTab = 1 }) {
                Image(systemName: "calendar.badge.plus")
                    .font(.system(size: 28))
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button(action: { selectedTab = 2 }) {
                Image(systemName: "list.bullet")
                    .font(.system(size: 28))
            }
            .padding(.leading, 20)
            
            Spacer()
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
