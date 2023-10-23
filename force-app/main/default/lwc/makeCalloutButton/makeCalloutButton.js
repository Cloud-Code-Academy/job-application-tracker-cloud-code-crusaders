import { LightningElement, wire } from 'lwc';
import postJoobleCallout from '@salesforce/apex/JoobleCallout.postJoobleCallout';


/*export default class MakeCalloutButton extends LightningElement {

   @wire (postJoobleCallout) newJobs;

        
   
       const calloutURL = 'https://jooble.org/api/2a3be2fb-3555-410e-924b-8e2c964de9d3';
        fetch(calloutURL, {
            method: "POST"})
            .then(response => {
            console.log(response);
              if (response.ok) {
                return response.json();
            } else {
                throw Error(response);
            }
            });
    }
}
