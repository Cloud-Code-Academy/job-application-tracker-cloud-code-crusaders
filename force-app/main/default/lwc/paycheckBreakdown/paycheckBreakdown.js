import { LightningElement } from 'lwc';

export default class PaycheckBreakdown extends LightningElement {
    yearlyPay = 0;
    sixMonthsPay = 0;
    monthlyPay = 0;
    biWeeklyPay = 0;
    weeklyPay = 0;

    calculatePay(event) {
        const inputValue = event.target.value.trim();

        if (inputValue === '') {
            // If the input is empty, reset all values to zero
            this.yearlyPay = 0;
            this.sixMonthsPay = 0;
            this.monthlyPay = 0;
            this.biWeeklyPay = 0;
            this.weeklyPay = 0;
        } else {
            // If the input is not empty, proceed with calculations
            this.yearlyPay = parseFloat(inputValue).toFixed(2); // Fix the property name and parse the input as a float

            // Calculate other pay values here
            this.sixMonthsPay = (this.yearlyPay / 2).toFixed(2);
            this.monthlyPay = (this.yearlyPay / 12).toFixed(2);
            this.biWeeklyPay = (this.yearlyPay / 26).toFixed(2);
            this.weeklyPay = (this.yearlyPay / 52).toFixed(2);
        }
    }
}
