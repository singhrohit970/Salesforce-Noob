import { LightningElement, wire } from "lwc";
import getAccountData from "@salesforce/apex/AccountController1.getAccountData";

export default class AccountDataTable extends LightningElement {
  accountData = [];
  selectedRows = [];
  selectedAccountId = "";

  columns = [
    { label: "Name", fieldName: "Name", type: "text" },
    { label: "Industry", fieldName: "Industry", type: "text" },
    { label: "Phone", fieldName: "Phone", type: "text" },
    { label: "Website", fieldName: "Website", type: "url" }
  ];

  @wire(getAccountData)
  wiredAccountData({ error, data }) {
    if (data) {
      this.accountData = data;
    } else if (error) {
      // Handle error
    }
  }

  handleRowSelection(event) {
    this.selectedRows = event.detail.selectedRows;
    if (this.selectedRows.length > 0) {
      this.selectedAccountId = this.selectedRows[0].Id;
    } else {
      this.selectedAccountId = "";
    }
  }
}