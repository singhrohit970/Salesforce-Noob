import { LightningElement, api } from "lwc";

export default class ChildComponent extends LightningElement {
  @api itemName = "Salesforce Noob";

  //   declare the function with api decorator
  @api handleChangeValue() {
    this.itemName = "Salesforce LWC Demo";
  }
}