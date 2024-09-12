import { LightningElement, track } from "lwc";
import getContactDetails from "@salesforce/apex/GetChild.getContactDetails";

export default class TreeGridDemo extends LightningElement {
  // created gridColumns name array of object where we have passed the below
  // property
  @track gridColumns = [
    {
      type: "text",
      fieldName: "Name",
      label: "Name"
    },

    {
      type: "text",
      fieldName: "FirstName",
      label: "First Name"
    },

    {
      type: "text",
      fieldName: "LastName",
      label: "Last Name"
    }
  ];

  @track gridData;

  connectedCallback() {
    // imperative call
    getContactDetails()
      .then((result) => {
        // console.log("result:" + JSON.stringify(result));
        //we have created clone of the object
        var tempContact = JSON.parse(JSON.stringify(result));
        // console.log("tempContact:" + JSON.stringify(tempContact));

        for (var i = 0; i < tempContact.length; i++) {
          var newContact = tempContact[i]["Contacts"];
          // console.log("newContact:" + JSON.stringify(newContact));

          if (newContact) {
            tempContact[i]._children = newContact;
            // console.log(
            //   "tempContact[i]._children:" +
            //     JSON.stringify(tempContact[i]._children)
            // );
            delete tempContact[i].Contacts;
          }
        }

        this.gridData = tempContact;
        // console.log("this.gridData:" + JSON.stringify(this.gridData));
      })

      .catch((error) => {
        console.error(JSON.stringify(error));
      });
  }

  getselectedRows(event) {
    const selectedRows = event.detail.selectedRows;
    console.log("selectedRows:" + JSON.stringify(selectedRows));

    for (var i = 0; i < selectedRows.length; i++) {
      console.log("FirstName:" + selectedRows[i].FirstName);
      console.log("LastName:" + selectedRows[i].LastName);
    }
  }
}