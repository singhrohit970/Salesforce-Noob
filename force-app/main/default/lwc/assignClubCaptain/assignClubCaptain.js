import { LightningElement, api, track } from "lwc";
import getPlayerList from "@salesforce/apex/assignClubCaptain.getPlayerList";
import assignClubCaptain from "@salesforce/apex/assignClubCaptain.assignClubCaptain";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";

const actions = [
  { label: "Assign", Name: "assign" },
  { label: "View", name: "view" }
];

const columns = [
  { label: "Players", fieldName: "Name" },
  { label: "Goals", fieldName: "Goals__c" },
  {
    type: "action",
    typeAttributes: { rowActions: actions }
  }
];

export default class AssignClubCaptain extends NavigationMixin(
  LightningElement
) {
  @track showPlayers = "Show Players";
  @track isVisible = false;
  @api recordId;

  @track data = [];
  @track playerData = [];

  columns = columns;
  error;

  connectedCallback() {
    console.log(this.recordId);

    //get player list from Apex Class
    getPlayerList({ selectedIdFromLwc: this.recordId })
      .then((result) => {
        this.data = result;
      })
      .catch((error) => {
        this.error = error;
      });
  }

  //show hide functionality of the button
  handleClick(event) {
    const label = event.target.label;

    if (label === "Show Players") {
      this.showPlayers = "Hide players";
      this.isVisible = true;
    } else if (label === "Hide players") {
      this.showPlayers = "Show Players";
      this.isVisible = false;
    }
  }

  handleRowAction(event) {
    const actionName = event.detail.action.name;
    const row = event.detail.row;

    switch (actionName) {
      case "assign":
        this.assignCaptain(row);
        break;

      case "view":
        this.navigateToPlayerRecordPage(row);
        break;
      default:
    }
  }

  assignCaptain(currentRow) {
    const selectedRow = currentRow;

    //sending selected row id to apex method assignCaptain in lwcRowId
    assignClubCaptain({ lwcRowId: selectedRow.Id })
      .then((result) => {
        this.playerDate = result;
      })
      .catch((error) => {
        this.error = error;
      });
    this.showSuccessToast();
    //window.location.reload; // for refresh page
  }

  showSuccessToast() {
    const event = new ShowToastEvent({
      label: "Record Updated",
      message: "Captain Assigned successfully",
      variant: "success",
      mode: "dismissable"
    });
    this.dispatchEvent(event);
  }

  //player record page navigation
  navigateToPlayerRecordPage(rowData) {
    const player = rowData;

    this[NavigationMixin.Navigate]({
      type: "standard_recordpage",
      attributes: {
        recordId: player.Id,
        actionName: "view"
      }
    });
  }
}