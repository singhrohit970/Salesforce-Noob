import { LightningElement, track } from "lwc";
import getAccounts from "@salesforce/apex/comboBox.getAccounts";

export default class ComboboxDemobyNoob extends LightningElement {
  @track value = "";
  @track accOption = [];

  get options() {
    return this.accOption;
  }

  connectedCallback() {
    //imperative method call
    getAccounts().then((result) => {
      let arr = [];
      for (var i = 0; i < result.length; i++) {
        arr.push({ label: result[i].Name, value: result[i].Id });
      }
      this.accOption = arr;
    });
  }
  handleChanged(event) {
    this.value = event.detail.value;
  }
}