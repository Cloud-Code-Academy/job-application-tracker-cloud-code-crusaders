@isTest
public class DupeCheckTest {

    @isTest
    static void testCheckForDupes() {
        // Create a list of new events with duplicate start times
        List<Event> newEvents = new List<Event>();
        
        Event event1 = new Event(
            StartDateTime = Datetime.newInstance(2023, 11, 5, 10, 0, 0),
            DurationInMinutes = 60
        );
        Event event2 = new Event(
            StartDateTime = Datetime.newInstance(2023, 11, 5, 11, 0, 0),
            DurationInMinutes = 60
        );
        Event event3 = new Event(
            StartDateTime = Datetime.newInstance(2023, 11, 5, 10, 0, 0),
            DurationInMinutes = 60
        ); // Duplicate
        
        newEvents.add(event1);
        newEvents.add(event2);
        newEvents.add(event3);
        
        // Insert the new events into the database
        insert newEvents;
        
        // Call the checkForDupes method
        DupeCheck.checkForDupes(newEvents);
        
        // Verify that the duplicate event has an error message
        for (Event newEvent : newEvents) {
            List<Database.Error> errors = newEvent.getErrors();
            
            if (!errors.isEmpty() && newEvent.StartDateTime == Datetime.newInstance(2023, 11, 5, 10, 0, 0)) {
                System.assertEquals('Another event with the same start time already exists.', errors[0].getMessage());
            } else {
                System.assert(errors.isEmpty());
            }
        }
    }
}
