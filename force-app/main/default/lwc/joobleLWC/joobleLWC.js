import { LightningElement } from 'lwc';

import fetchDataHelper from './fetchDataHelper';

const columns = [
    { label: 'title', fieldName: 'Job Application Name' },
    { label: 'location', fieldName: 'location' },
    { label: 'company', fieldName: 'Company Name' },
    { label: 'salary', fieldName: 'salary', type: 'currency' },
    { label: 'snippet', fieldName: 'description' },
];

export default class LightningTable extends LightningElement {

    data = [];
    columns = columns;
    
    // async-await method 
    async connectedCallback() {
        const data = await fetchDataHelper({ amountOfRecords: 100 });
        this.data = data;
    }
}