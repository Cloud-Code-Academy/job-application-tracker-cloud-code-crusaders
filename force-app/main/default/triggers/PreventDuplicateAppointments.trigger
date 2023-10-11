trigger PreventDuplicateAppointments on Event (before insert, before update) {
    Set<Datetime> appointmentTimes = new Set<Datetime>();

    // Check for duplicates in new and updated records
    for (Event event : Trigger.new) {
        // Check if the event is an Appointment
        if (event.IsAllDayEvent == false) {
            // Ensure the Event has a start date and time
            if (event.StartDateTime != null) {
                // Add the start date and time to the set
                appointmentTimes.add(event.StartDateTime);
            }
        }
    }

    // Query for existing events with the same appointment times
    List<Event> existingEvents = [SELECT Id, StartDateTime FROM Event
                                  WHERE StartDateTime IN :appointmentTimes];

    // Map to store appointment times and their occurrence count
    Map<Datetime, Integer> appointmentTimeCount = new Map<Datetime, Integer>();

    // Check for duplicates in the existing events
    for (Event existingEvent : existingEvents) {
        Datetime existingTime = existingEvent.StartDateTime;

        if (appointmentTimeCount.containsKey(existingTime)) {
            // If the appointment time is already in the map, increment the count
            appointmentTimeCount.put(existingTime, appointmentTimeCount.get(existingTime) + 1);
        } else {
            // If it's not in the map, add it with a count of 1
            appointmentTimeCount.put(existingTime, 1);
        }
    }

    // Check for appointment times with a count > 1 (duplicates)
    for (Event event : Trigger.new) {
        if (event.IsAllDayEvent == false && event.StartDateTime != null) {
            if (appointmentTimeCount.containsKey(event.StartDateTime) && appointmentTimeCount.get(event.StartDateTime) > 1) {
                // If the appointment time is a duplicate, add an error to the record
                event.addError('Another appointment already exists at this time.');
            }
        }
    }
}
