import { LightningElement, wire, track } from "lwc";
import { loadScript } from "lightning/platformResourceLoader";
import getTerritories from "@salesforce/apex/ShowTerritories.getTerritories";
import getAccountCount from "@salesforce/apex/ShowTerritories.getAccountCount";

const columns = [{ label: "Name", fieldName: "Name" }];

export default class AirLiquide extends LightningElement {
  @track accountCount = 0;
  @track columns = columns;
  @track data = [];

  @wire(getTerritories)
  wiredPlayers({ data, error }) {
    if (data) {
      this.data = data;
    } else if (error) {
      console.log("error occured");
    }
  }

  // Function to fetch the count of Account records
  fetchAccountCount() {
    getAccountCount()
      .then((result) => {
        this.accountCount = result;
        console.log("Appointment Count:" + JSON.stringify(this.accountCount));
      })
      .catch((error) => {
        console.error("Error fetching Account count:", error);
      });
  }
}