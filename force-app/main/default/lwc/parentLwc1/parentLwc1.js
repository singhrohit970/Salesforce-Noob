import { LightningElement } from "lwc";

export default class ParentLwc1 extends LightningElement {
  startCounter = 0;

  handleStartChange(event) {
    this.startCounter = event.target.value;
  }
}