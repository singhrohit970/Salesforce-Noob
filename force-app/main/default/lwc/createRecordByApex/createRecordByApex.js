import { LightningElement, track } from "lwc";
import createRecord from "@salesforce/apex/CreateUpdateRecord.createRecord";

export default class CreateRecordByApex extends LightningElement {
  accountIds;
  accountName;
  accountIndustry;
  //get the value of account Name as provided by user on the UI
  handleNameChange(event) {
    this.accountName = event.target.value;
  }
  // getting the value of industry as provided by the user on the UI

  handleIndustryChange(event) {
    this.accountIndustry = event.target.value;
  }

  onCreateRecord() {
    createRecord({
      accountNames: this.accountName,
      accountIndustries: this.accountIndustry
    })
      .then((result) => {
        this.accountIds = result[0].Id;
        console.log("result:" + JSON.stringify(result));
      })
      .catch((error) => {
        console.error("Error:" + JSON.stringify(error));
      });
  }
}