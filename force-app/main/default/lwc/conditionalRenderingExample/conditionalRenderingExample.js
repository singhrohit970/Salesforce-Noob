import { LightningElement, track } from "lwc";

export default class ConditionalRenderingExample extends LightningElement {
  @track displayDiv = false;
  @track cityList = ["Jaipur", "Bangalore", "Hyderabad", "Delhi"];

  showDivHandler(event) {
    this.displayDiv = event.target.checked;
  }
}