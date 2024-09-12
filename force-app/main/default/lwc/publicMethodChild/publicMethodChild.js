import { LightningElement, api, track } from "lwc";

export default class PublicMethodChild extends LightningElement {
  @track value = ["Red"];

  options = [
    { label: "Blue Marker", value: "Blue" },
    { label: "Green Marker", value: "Green" },
    { label: "Black Marker", value: "Black" },
    { label: "Red Marker", value: "Red" }
  ];

  @api selectCheckbox(checkboxValue) {
    const selectedCheckbox = this.options.find((checkbox) => {
      return checkboxValue === checkbox.value;
    });
    if (selectedCheckbox) {
      this.value = selectedCheckbox.value;
      return "Successfully Checked";
    }
    return "No checkbox found";
  }
}