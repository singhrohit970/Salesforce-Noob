import { LightningElement, wire, api, track } from "lwc";
import { updateRecord } from "lightning/uiRecordApi";
import { getRecord } from "lightning/uiRecordApi";
//import CUSTOM_OBJECT from "@salesforce/schema/FSL__Optimization_Request__c";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class FSL__Optimization_Request__c extends LightningElement {
  @api recordId = "a0e2w00000CavQnAAJ"; // Id of the custom object record
  @track dateTimeValue;

  // Load the initial DateTime value when the component loads
  @wire(getRecord, {
    recordId: "$recordId",
    fields: [FSL__Optimization_Request__c.FSL__Start__c]
  })
  loadDateTime({ error, data }) {
    if (data) {
      this.dateTimeValue = data.fields.FSL__Start__c.value;
    }
  }

  // Handle changes to the DateTime input field
  handleDateTimeChange(event) {
    this.dateTimeValue = event.target.value;
  }

  // Save the updated DateTime value to the custom object
  saveDateTime() {
    const fields = {};
    fields[FSL__Optimization_Request__c.FSL__Start__c.fieldApiName] =
      this.dateTimeValue;

    const recordInput = { fields };
    recordInput.Id = this.recordId;
    console.log("Print value:" + JSON.stringify(recordInput.Id));

    updateRecord(recordInput)
      .then(() => {
        // Optionally, display a success message
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Date/Time updated successfully.",
            variant: "success"
          })
        );
      })
      .catch((error) => {
        // Handle any errors and display an error message
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error",
            message: "Error updating Date/Time: " + error.body.message,
            variant: "error"
          })
        );
      });
  }
}