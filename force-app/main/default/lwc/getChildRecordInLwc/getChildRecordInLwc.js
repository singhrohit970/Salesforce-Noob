import { LightningElement, api } from "lwc";
import getChildDetails from "@salesforce/apex/GetContactOpportunityDetails.getChildDetails";

//Declaring columns of datatable
const columns1 = [
  { label: "Opportunity Id", fieldName: "Id" },
  { label: "Opportunity Name", fieldName: "Name" }
];

// Declaring columns for contact datatable
const columns2 = [
  { label: "Contact Id", fieldName: "Id" },
  { label: "Contact Name", fieldName: "Name" }
];

export default class GetChildRecordInLwc extends LightningElement {
  @api buttonLabel = "Show";
  opportunityData = []; //this array will store opportunity details
  contactData = []; //this array will store contact details

  columns1 = columns1;
  columns2 = columns2;

  @api recordId; //this property store the current account trcoedId
  @api showDatatable = false;

  opportunityTempArray = [];
  contactTempArray = [];
  //  this method called when user click the button

  handleShow(event) {
    // if the user clicks show button then Datatable show visible and button become Hide
    if (event.target.label === "Show") {
      this.buttonLabel = "Hide";
      this.showDatatable = true;
    }
    // if user click the hide button then Datatable will become invisible and button become show
    else if (event.target.label === "Hide") {
      this.buttonLabel = "Show";
      this.showDatatable = false;
    }
  }

  connectedCallback() {
    //calling the apex method by passing current record account id

    getChildDetails({ recId: this.recordId })
      .then((res) => {
        let tempRecords = res;
        console.log("tempRecords:" + JSON.stringify(tempRecords));

        //create two object for storing opportunities and contacts details
        let temp = tempRecords.map((row) => {
          return Object.assign({
            OppName: row.Opportunities,
            ContactName: row.Contacts
          });
        });
        console.log("temp >>:" + JSON.stringify(temp));
        //store the opportunity and contact details in differnt array

        temp.forEach((element) => {
          //opportunity array
          this.opportunityTempArray = element.OppName;
          console.log(
            "this.opportunityTempArray:" +
              JSON.stringify(this.opportunityTempArray)
          );
          //contact array
          this.contactTempArray = element.ContactName;
          console.log(
            "this.contactTempArray:" + JSON.stringify(this.contactTempArray)
          );
        });
        //data for opp datatable
        this.opportunityData = this.opportunityTempArray;

        //data for contact datatable
        this.contactData = this.contactTempArray;
      })

      .catch((error) => {
        console.error("error:" + JSON.stringify(error));
      });
  }
}