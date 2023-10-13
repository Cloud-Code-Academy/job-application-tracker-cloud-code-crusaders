import { LightningElement } from 'lwc';

export default class PaycheckBreakdown extends LightningElement {
    yearlyPay = 0;
    sixMonthsPay = 0;
    monthlyPay = 0;
    biWeeklyPay = 0
    weeklyPay = 0;
    
    calculatePay(event) {
        this.yearlyPay = parseFloat(event.target.value);

        // Calculate other pay values here
        this.sixMonthsPay = (parseFloat(this.yearlyPay) / 2).toLocaleString(undefined, { maximumFractionDigits: 2 });
        this.monthlyPay = (parseFloat(this.yearlyPay) / 12).toLocaleString(undefined, { maximumFractionDigits: 2 });
        this.biWeeklyPay = (parseFloat(this.yearlyPay) / 26).toLocaleString(undefined, { maximumFractionDigits: 2 });
        this.weeklyPay = (parseFloat(this.yearlyPay) / 52).toLocaleString(undefined, { maximumFractionDigits: 2 });
    }
}