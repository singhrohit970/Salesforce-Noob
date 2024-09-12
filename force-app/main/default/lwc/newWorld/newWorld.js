import { LightningElement, wire, track, api } from 'lwc';
import getName from '@salesforce/apex/NewWorldWrapper.getName';
import getAddress from '@salesforce/apex/NewWorldWrapper.getAddress';
export default class NewWorld extends LightningElement {
    submit() {
        console.log("Hello");
        alert("Hello");
    //}
    //connectedCallback() {
        getName()
            .then(result => {

                alert(result);

            })

            .catch(error => {

                alert(result);

            });


            getAddress()
            .then(result => {

                alert(result);

            })

            .catch(error => {

                alert(result);

            });
    }
}