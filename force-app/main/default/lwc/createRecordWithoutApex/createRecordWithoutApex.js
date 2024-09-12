import { LightningElement } from "lwc";
import { createRecord } from "lightning/uiRecordApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";

export default class CreateRecordWithoutApex extends LightningElement {
  accountId;
  name = "";

  handleNameChange(event) {
    this.name = event.target.value;
    // console.log("this.name:" + JSON.stringify(this.name));
  }

  handleCreateAccount() {
    // create an empty object named fields
    const fields = {};
    //Account ka name field ka jo Api name h usme  this.name pass kara do
    fields[NAME_FIELD.fieldApiName] = this.name;
    console.log("fields:" + JSON.stringify(fields));

    //here in recordId we are taking reference of Account object api name and field api name and its value
    const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };

    createRecord(recordInput)
      .then((account) => {
        console.log("account:" + JSON.stringify(account));
        this.accountId = account.id;
      })

      .catch((error) => {
        console.error("error:" + JSON.stringify(error));
      });
  }
}