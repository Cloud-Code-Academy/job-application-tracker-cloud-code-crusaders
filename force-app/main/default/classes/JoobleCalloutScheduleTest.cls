@isTest
public class JoobleCalloutScheduleTest {

        public static String CRON_EXP = '0 0 0 27 10 ? 2023';
        
        @isTest
        static void test1() 
        {
            Test.startTest();
            String jobId = System.schedule('Make Jooble Callout',
                                           CRON_EXP, 
                                           new JoobleCalloutSchedule());
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                              FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, 
                                ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
            System.assertEquals('2023-10-27 00:00:00', 
                                String.valueOf(ct.NextFireTime));
            Test.stopTest();
        }
    }