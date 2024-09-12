import { LightningElement, api } from "lwc";
import getRelatedContacts from "@salesforce/apex/DatatableDemo.getRelatedContacts";

const columnData = [
  { label: "Name", fieldName: "Name" },
  { label: "Phone", fieldName: "Phone" }
];

export default class DatatableWithRowSelectionDemo extends LightningElement {
  buttonLabel = "Show Contacts";
  @api recordId; //whichever record page we are in currently. it will give the id for that record.
  contactData;
  column = columnData;
  isDatatableVisible = false;
  searchkey = "";

  //using getRelatedContacts methord reference we can get the contact list details
  //jaise hi hamra component load hoga by default hm data chahiye. We can use connectedcallback 
  //which run automaticalll whenever LWC component get loaded.c/lwcDatatableWithInlineeditDemo


//jb bhi app imperative method k through call karte ho then return m kuch na kuch aayega ya to wo successfull result ho sakta h ya error
//so jo successfull hoga usko get karne k liye then method ka use krna h and koi bi naam ka parameter pass kr sakte ho.
//jo apex method return kr rha h wo result m store ho jayega


//Calling here by imperative method.
connectedCallback() {
    getRelatedContacts({
      accountRecordId: this.recordId,
      searchValue: this.searchkey
    })
      .then((result) => {
        this.contactData = result;
        console.log("this.contactData:" + JSON.stringify(this.contactData));
      })

      .catch((error) => {
        console.log("Error:" + JSON.stringify(error));
      });
  }
//Show/Hide Button Functionality
  handleClick(event) {
    const label = event.target.label;
    console.log("Label:" + JSON.stringify(label));

    if (label == "Show Contacts") {
      this.buttonLabel = "Hide Contacts";
      this.isDatatableVisible = true;
    } else {
      this.buttonLabel = "Show Contacts";
      this.isDatatableVisible = false;
    }
  }

  handleChange(event) {
    this.searchkey = event.target.value;
    getRelatedContacts({
      accountRecordId: this.recordId,
      searchValue: this.searchkey
    })
      .then((result) => {
        this.contactData = result;
        console.log("this.contactData:" + JSON.stringify(this.contactData));
      })

      .catch((error) => {
        console.log("Error:" + JSON.stringify(error));
      });

    this.searchkey = event.target.value;
    console.log("this.searchkey:" + JSON.stringify(this.searchkey));
  }

  handleSelectedRow(event) {
    const selectedRow = event.detail.selectedRows;
    console.log("selectedRow:" + JSON.stringify(selectedRow));
  }
}