@isTest
private class PreventDuplicateAppointmentsTest {

    static testMethod void testPreventDuplicateAppointments() {

        Id userId = [SELECT Id FROM User WHERE Username = 'cloudcodecrusaders@cloudcodeacademy.com' LIMIT 1].Id; // Get User Id

        // Create the first event
        Event newEvent = new Event();
        newEvent.OwnerId = userId;
        newEvent.Subject = 'Interview with Company';
        newEvent.StartDateTime = Datetime.newInstance(2023, 10, 18, 10, 0, 0);
        newEvent.EndDateTime = Datetime.newInstance(2023, 10, 18, 11, 0, 0);

        // Insert the first event
        insert newEvent;

        // Attempt to create a duplicate event with the same start and end times
        Event newEvent1 = new Event();
        newEvent1.OwnerId = userId;
        newEvent1.Subject = 'Interview with Company';
        newEvent1.StartDateTime = Datetime.newInstance(2023, 10, 18, 10, 0, 0);
        newEvent1.EndDateTime = Datetime.newInstance(2023, 10, 18, 11, 0, 0);

        try {
            insert newEvent1;
            System.assert(false, 'Expected an error but the duplicate event was created.');
        } catch (DmlException e) {
            // Check for the expected error message
            System.assertEquals('A scheduling conflict has been detected. Please choose a different time slot.', e.getDmlMessage(0));
        }
    }
}