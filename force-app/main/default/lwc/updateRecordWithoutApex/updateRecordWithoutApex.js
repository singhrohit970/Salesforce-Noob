import { LightningElement } from "lwc";
import ID_FIELD from "@salesforce/schema/Account.Id";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import { updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class UpdateRecordWithoutApex extends LightningElement {
  handleIdChange(event) {
    this.idValue = event.target.value;
  }

  handleNameChange(event) {
    this.nameValue = event.target.value;
  }

  handleUpdateAccount() {
    const fields = {};
    fields[ID_FIELD.fieldApiName] = this.idValue;
    fields[NAME_FIELD.fieldApiName] = this.nameValue;
    console.log("fields:" + JSON.stringify(fields));

    const recordInput = { fields };
    updateRecord(recordInput)
      .then((result) => {
        console.log("result:" + JSON.stringify(result));
        this.showToast();
      })
      .catch((error) => {
        console.error("error:" + JSON.stringify(error));
      });
  }

  showToast() {
    const event = new ShowToastEvent({
      title: "Account Updated",
      message: "Account Updated",
      variant: "success"
    });
    this.dispatchEvent(event);
  }
}