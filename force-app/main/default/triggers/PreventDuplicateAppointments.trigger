trigger PreventDuplicateAppointments on Event (before insert, before update) {

    String thisId; //an event will always overlap with itself so omit it from the query
    String resource; //only treat events as conflicts when they share the same resource
    Datetime startDate;
    Datetime endDate;
    
    for (Event newEvent : trigger.new){
        thisId = newEvent.Id;
        resource = newEvent.OwnerId;
        startDate = newEvent.StartDateTime;
        endDate = newEvent.EndDateTime;
        
        List<Event> events = [SELECT Id FROM Event WHERE EndDateTime > :startDate AND StartDateTime < :endDate AND OwnerId = :resource AND ID != :thisId];
        if (!events.isEmpty()) { 
            newEvent.addError('A scheduling conflict has been detected. Please choose a different time slot.');
        }
    }
}