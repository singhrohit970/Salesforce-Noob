import { LightningElement,api } from 'lwc';
import {CloseActionScreenEvent} from 'lightning/actions';
import {updateRecord} from 'lightning/uiRecordApi';
import ID_field from '@salesforce/schema/Account.Id'
import Phone_field from '@salesforce/schema/Account.Phone'


export default class LwcUpdateUsingScreenAction extends LightningElement {
@api recordId;
userInput;


handleChange(event){
    this.userInput = event.target.value;
    console.log("this.userInput:" +JSON.stringify(this.userInput))
}
handleClick(){
//fire the event
//whenever we want to use update method to update any record then we need to create an object and pass values
//Id and field 

// update record logic start here
const fields={};
fields[ID_field.fieldApiName] = this.recordId;
fields[Phone_field.fieldApiName] =  this.userInput;

//here data preperation is done for update operation
const recordInput={
    fields:fields
};
console.log("recordInput: "+JSON.stringify(recordInput));

updateRecord(recordInput)
.then(result=>{
    console.log(JSON.stringify(result));
})
.catch(error=>{
    console.log("Error:" +JSON.stringify(error))
})

//update record logic ends here
this.dispatchEvent(new CloseActionScreenEvent());
}

}