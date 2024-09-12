import { LightningElement } from "lwc";

export default class LwcConditionalRendering extends LightningElement {
  buttonLabel = "Button 3";

  property1 = false;
  property2 = false;

  handleclick() {
    if (this.property1 == true) {
      this.property1 = false;
      this.property2 = true;
      this.buttonLabel = "Button 2";
    } else {
      this.property2 = false;
      this.property1 = true;
      this.buttonLabel = "Button 1";
    }
  }
}