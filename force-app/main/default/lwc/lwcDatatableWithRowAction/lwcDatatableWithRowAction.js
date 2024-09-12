import { LightningElement, api } from "lwc";
import getrelatedContact from "@salesforce/apex/ContactClass.getrelatedContact";
import { NavigationMixin } from "lightning/navigation";
import updateSecondaryContact from "@salesforce/apex/ContactClass.updateSecondaryContact";
import { ShowToastEvent } from "lightning/platformShowToastEvent";


//action column creation. The action column created here. we need to pass it to main column
const actions = [
  { label: "Assign", name: "assign" },
  { label: "View", name: "view" }
];

const columnData = [
  { label: "Name", fieldName: "Name" },
  { label: "Phone", fieldName: "Phone" },
   
//passing action column to main column
  {
    type: "action",
    typeAttributes: { rowActions: actions }
  }
];

//we have done encapsulation here as becoz of navigationmixin
export default class LwcDatatableWithRowAction extends NavigationMixin(
  LightningElement
) {
  columns = columnData;
  @api recordId; //current account record Id
  contactData;
//imperative call
  connectedCallback() {
    getrelatedContact({ accId: this.recordId })
      .then((result) => {
        this.contactData = result;

        console.log(" this.contactData" + JSON.stringify(this.contactData));
      })
      .catch((error) => {
        this.error = error;
        console.log("error" + JSON.stringify(error));
      });
  }

  handleClick() {
    this[NavigationMixin.Navigate]({
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Contact",// which object creation form we need
        actionName: "new"
      }
    });
  }

  handleRowAction(event) {
    const actionName = event.detail.action.name;// we will get the value from the action table
    console.log("actionName" + JSON.stringify(actionName));

    const rowData = event.detail.row;// will get the id of particular row
    console.log("rowData" + JSON.stringify(rowData));

    if (actionName == "assign") {
      this.assignContact(rowData);
    } else if (actionName == "view") {
      this.navigateToContactRecord(rowData);
    }
  }

  //this methos will assign primary contact
  assignContact(row) {
    console.log("row for assign contact:" + JSON.stringify(row));
    updateSecondaryContact({ accId: this.recordId, contactRowId: row.Id })
    //handle promise
      .then((result) => {
        console.log("result:" + JSON.stringify(result));

        //show toast message
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Message",
            message: result,
            variant: "brand"
          })
        );
      })
      .catch((error) => {
        console.log("error:" + JSON.stringify(error));
      });
  }

  navigateToContactRecord(row) {
    //this method will navigate user to selected contact
    console.log("row for navigate to contact" + JSON.stringify(row));
    //we will get only id using row.Id
    console.log("row Id for navigate to contact:" + JSON.stringify(row.Id));

    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: row.Id,
        actionName: "view"
      }
    });
  }
}