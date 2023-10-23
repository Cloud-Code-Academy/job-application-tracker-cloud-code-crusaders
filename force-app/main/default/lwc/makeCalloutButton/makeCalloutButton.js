import { LightningElement, track } from 'lwc';

export default class JoobleCallout extends LightningElement {

    @track MakeCalloutButton;

    makeCallout() {

       const calloutURL = 'https://jooble.org/api/2a3be2fb-3555-410e-924b-8e2c964de9d3';
        fetch(calloutURL, {
            method: "POST"
        }).then((response) => response.json())
            .then(repos => {
                console.log(repos)
              //  this.MakeCalloutButton = repos.;
                console.log(this.MakeCalloutButton);
            });
    }
}