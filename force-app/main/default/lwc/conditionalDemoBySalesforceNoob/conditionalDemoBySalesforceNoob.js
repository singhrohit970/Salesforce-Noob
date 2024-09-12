import { LightningElement, track } from "lwc";

export default class ConditionalDemoBySalesforceNoob extends LightningElement {
  @track onClickedLabelButton = "Show";
  mytitle = "Salesforce NOOB";
  @track cardVisible = false;
  handleClick(event) {
    const label = event.target.label;

    if (label === "Show") {
      this.onClickedLabelButton = "Hide";
      this.cardVisible = true;
    } else if (label === "Hide") {
      this.onClickedLabelButton = "Show";
      this.cardVisible = false;
    }
  }
}