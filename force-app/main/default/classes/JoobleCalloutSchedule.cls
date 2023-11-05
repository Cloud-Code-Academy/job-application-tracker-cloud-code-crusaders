global class JoobleCalloutSchedule implements Schedulable {
    global void execute(SchedulableContext Sc){

        JoobleCallout.postJoobleCallout();
    }
}