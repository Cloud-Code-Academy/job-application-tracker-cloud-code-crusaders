trigger PreventDuplicateAppointments on Event (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            DupeCheck.checkForDupes(Trigger.new);
        }
    }
}