import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class RevisionLwc extends LightningElement {
  myTitle = "Salesforce Noob";
  //1st function
  handleClick() {
    this.showToast();
  }

  //2nd function
  showToast() {
    const event = new ShowToastEvent({
      title: "Display Toast Message",
      message: "Want to Display Toast Message",
      varient: "success"
    });
    this.dispatchEvent(event);
  }
}