import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ['Job_Application__c.Salary__c'];
const socialSecurityRate = .0620;
const medicareWithholdingRate = .0145;
const federalTaxRates = [
    { minIncome: 0, maxIncome: 10275, rate: 0.10 },
    { minIncome: 10276, maxIncome: 41775, rate: 0.12 },
    { minIncome: 41776, maxIncome: 89075, rate: 0.22 },
    { minIncome: 89076, maxIncome: 170050, rate: 0.24 },
    { minIncome: 170051, maxIncome: 215950, rate: 0.32 },
    { minIncome: 215951, maxIncome: 539900, rate: 0.35 },
    { minIncome: 539901, maxIncome: Infinity, rate: 0.37 },
];
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