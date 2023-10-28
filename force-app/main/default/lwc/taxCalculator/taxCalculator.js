import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ['Job_Application__c.Salary__c'];
export default class TaxCalculator extends LightningElement {
    salary = 0;
    yearlyPay = 0;
    sixMonthsPay = 0;
    monthlyPay = 0;
    biWeeklyPay = 0;
    federalWithholdings = 0;
    socialSecurityWithholdings = 0;
    medicareWitholdings = 0;
    retrievedSalary = 0;
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredRecord({ error, data }) {
        if (data) {
            this.retrievedSalary = data.fields.Salary__c.value;
            this.handleCalculations();
        } else if (error) {
            // Handle error here
        }
    }
    handleCalculations() {
        this.salary = this.retrievedSalary;
        for (const bracket of federalTaxRates) {
            if (this.salary >= bracket.minIncome && this.salary <= bracket.maxIncome) {
                const federalTax = (bracket.rate * this.salary) - (bracket.minIncome * bracket.rate);
                this.federalWithholdings = federalTax;
                this.yearlyPay = this.salary - (federalTax + (this.salary * socialSecurityRate) + (this.salary * medicareWithholdingRate));
                break;
            }
        }
        // Calculate Social Security Tax and Medicare Tax if salary is greater than zero
        if (this.salary > 0) {
            this.socialSecurityWithholdings = this.salary * socialSecurityRate;
            this.medicareWitholdings = this.salary * medicareWithholdingRate;
        } else {
            this.socialSecurityWithholdings = 0;
            this.medicareWitholdings = 0;
        }
        // Calculate other pay values
        this.yearlyPay = parseFloat(this.yearlyPay).toFixed(2);
        this.sixMonthsPay = (parseFloat(this.yearlyPay) / 2).toFixed(2);
        this.monthlyPay = (parseFloat(this.yearlyPay) / 12).toFixed(2);
        this.biWeeklyPay = (parseFloat(this.yearlyPay) / 26).toFixed(2);
    }
}