public with sharing class DupeCheck {
    public static void checkForDupes(List<Event> newEvents) {
        Set<DateTime> startTimes = new Set<DateTime>();

        // Populate the set with the start times of the new events
        for (Event event : newEvents) {
            startTimes.add(event.StartDateTime);
        }

        // Query for existing events with the same start times
        List<Event> existingEvents = [SELECT Id, StartDateTime FROM Event WHERE StartDateTime IN :startTimes];

        // Create a map to store the start times and corresponding event Ids
        Map<DateTime, Id> startTimeToEventIdMap = new Map<DateTime, Id>();
        for (Event existingEvent : existingEvents) {
            startTimeToEventIdMap.put(existingEvent.StartDateTime, existingEvent.Id);
        }

        // Check for duplicates and add error messages to the new events
        for (Event newEvent : newEvents) {
            if (startTimeToEventIdMap.containsKey(newEvent.StartDateTime) && 
                startTimeToEventIdMap.get(newEvent.StartDateTime) != newEvent.Id) {
                newEvent.addError('Another event with the same start time already exists.');
            }
        }
    }
}