import { LightningElement, api } from "lwc";
import updateRecord from "@salesforce/apex/CreateUpdateRecord.updateRecord";
export default class UpdateRecordByApex extends LightningElement {
  @api recordId;
  accountName;
  accountIndustry;
  handleNameChange(event) {
    this.accountName = event.target.value;
    console.log("this.accountName:" + JSON.stringify(this.accountName));
  }

  handleIndustryChange(event) {
    this.accountIndustry = event.target.value;
    console.log("this.accountIndustry:" + JSON.stringify(this.accountIndustry));
  }

  onUpdateRecord() {
    updateRecord({
      accountId: this.recordId,
      accountNames: this.accountName,
      accountIndustries: this.accountIndustry
    })
      .then((accountDetails) => {
        console.log("accountDetails:" + JSON.stringify(accountDetails));
      })
      .catch((error) => {
        console.log("Error:" + JSON.stringify(error));
      });
  }
}