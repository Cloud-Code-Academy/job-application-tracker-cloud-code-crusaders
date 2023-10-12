import { LightningElement } from 'lwc';
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
   
    calculatePay(event) {
        this.salary = parseFloat(event.target.value);
    
        // For calculating Federal Tax, you can loop through the tax brackets
        for (const bracket of federalTaxRates) {
            if (this.salary >= bracket.minIncome && this.salary <= bracket.maxIncome) {
                const federalTax = (bracket.rate * this.salary) - (bracket.minIncome * bracket.rate);
                this.yearlyPay = (this.salary - (federalTax + (this.salary * socialSecurityRate) + (this.salary * medicareWithholdingRate))).toLocaleString(undefined, { maximumFractionDigits: 2 });
                break;
            }
        }
    
        // Calculate other pay values here
        this.sixMonthsPay = (this.yearlyPay / 2).toLocaleString(undefined, { maximumFractionDigits: 2 });
        this.monthlyPay = (this.yearlyPay / 12).toLocaleString(undefined, { maximumFractionDigits: 2 });
        this.biWeeklyPay = (this.yearlyPay / 26).toLocaleString(undefined, { maximumFractionDigits: 2 });
    }
}   
