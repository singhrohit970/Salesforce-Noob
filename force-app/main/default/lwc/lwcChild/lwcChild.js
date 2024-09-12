import { LightningElement,api } from 'lwc';
import LightningAlert from 'lightning/alert';

export default class LwcChild extends LightningElement {
//api decorator for declaring the method public
    @api async sayHi(){
        await LightningAlert.open({

            message:"Hi , Salesforce Noob",
            theme: "success",
            label:"Greetings"
        });
    }
}