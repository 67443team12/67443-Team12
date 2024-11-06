import SwiftUI

struct EventEditView: View {
  let event: Event
  let trip: Trip
  let tripRepository: TripRepository
  let dayNumber: Int
  @State private var startTime = Date()
  @State private var endTime = Date()
  @State private var eventName = ""
    
    var body: some View {
      TextField("Enter event name", text: $eventName)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.bottom, 10)
      
      
      HStack {
        Text("Start Time")
          .font(.headline)
        Spacer()
        DatePicker("", selection: $startTime, displayedComponents: [.hourAndMinute])
          .labelsHidden()
      }
      .padding(.bottom, 10)
      
      HStack {
        Text("End Time")
          .font(.headline)
        Spacer()
        DatePicker("", selection: $endTime, displayedComponents: [.hourAndMinute])
          .labelsHidden()
      }
      .padding(.bottom, 20)
      
      Button("Save Event") {
        let newEvent = Event(
          id: UUID().uuidString,
          startTime: formatTime(date: startTime),
          endTime: formatTime(date: endTime),
          ratings: event.ratings,
          latitude: event.latitude,
          longitude: event.longitude,
          image: event.image,
          location: event.location,
          title: eventName,
          duration: event.duration,
          address: event.address,
          
          sunday: event.sunday,
          monday: event.monday,
          tuesday: event.tuesday,
          wednesday: event.wednesday,
          thursday: event.thursday,
          friday: event.friday,
          saturday: event.saturday
        )
        
        tripRepository.editEventInTrip(trip: trip, dayIndex: dayNumber - 1, eventId: event.id, updatedEvent: newEvent)
      }
    }
    
    // Helper function to convert Date to String in "h:mm a" format
    static func stringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    // Helper function to convert String to Date if possible, otherwise return nil
    static func dateFromString(_ timeString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.date(from: timeString)
    }
  
  private func formatTime(date: Date) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "hh:mm a"
      return dateFormatter.string(from: date)

  }

}
