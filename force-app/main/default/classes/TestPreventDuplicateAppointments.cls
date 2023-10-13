@isTest
public class PreventDuplicateAppointmentsTest {

    static testMethod void testConflictPrevention() {
        // Create an Event for the user
        Event event1 = new Event(
            Subject = 'Test Event 1',
            StartDateTime = DateTime.now(),
            EndDateTime = DateTime.now().addHours(1),
            OwnerId = user1.Id
        );
        insert event1;

        // Attempt to create an overlapping Event for the same user
        Event event2 = new Event(
            Subject = 'Test Event 2',
            StartDateTime = DateTime.now().addMinutes(30),
            EndDateTime = DateTime.now().addHours(1).addMinutes(30),
            OwnerId = user1.Id
        );

        Test.startTest();
        try {
            insert event2;
            System.assert(false, 'Insert should have thrown an error');
        } catch (DmlException e) {
            // Check that the error message contains the conflict message
            System.assert(e.getDmlMessage(0).contains('A scheduling conflict has been detected'));
        }
        Test.stopTest();

        // Create a non-conflicting Event
        Event event3 = new Event(
            Subject = 'Test Event 3',
            StartDateTime = DateTime.now().addHours(2),
            EndDateTime = DateTime.now().addHours(3),
            OwnerId = user1.Id
        );

        Test.startTest();
        try {
            insert event3;
        } catch (DmlException e) {
            System.assert(false, 'Insert should not have thrown an error');
        }
        Test.stopTest();
    }
}