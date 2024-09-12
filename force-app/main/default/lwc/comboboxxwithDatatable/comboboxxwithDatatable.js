import { LightningElement, track } from "lwc";
import getAccountDetails from "@salesforce/apex/comboboxwithDatatableDemo.getAccountDetails";
import getContactDetails from "@salesforce/apex/comboboxwithDatatableDemo.getContactDetails";

//Define columns for Datatable
const columns = [
  { label: "Contacts Name", fieldName: "Name" }, //fieldName is defined in object manager
  { label: "Contacts Email", fieldName: "Email" }
];

export default class ComboboxxwithDatatable extends LightningElement {
  @track value = "";
  @track optionsArray = []; //this array will store the options for combobox
  @track cardVisible = false; //used for show and hide card functionality
  @track data = []; // used for storing contact details in data-table
  @track columns = columns;

  //now store the option by returning the optionArray
  get options() {
    return this.optionsArray;
  }

  //call apex method to get account stored in salesforce org database
  connectedCallback() {
    getAccountDetails().then((response) => {
      //arrow function used. Here imoerative call is made so promise is return
      let arr = []; //This array store the account details in label and value pair
      for (var i = 0; i < response.length; i++) {
        //add the account name as label and Id as valur in arr []
        arr.push({ label: response[i].Name, value: response[i].Id });
      }

      //store the arr objects into optionsArray
      this.optionsArray = arr;
    });
  }

  //Get selected account recordid
  handleChangedValue(event) {
    //Whenever a account is selected in combbobox then card visible will become true and contact datatable will dispalyed to user
    this.cardVisible = true;

    //store selected accountid in "Value" property
    this.value = event.detail.value;
    // window.alert(JSON.stringify(this.value));

    //call the apex method to get the contact of slected Account

    getContactDetails({ SelectedAccountId: this.value }) // pass the selected account recordId to apex method to get related contacts
      .then((result) => {
        this.data = result;
      });
  }
}