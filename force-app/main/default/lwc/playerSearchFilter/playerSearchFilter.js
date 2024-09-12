import { LightningElement, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";

//for getting the value of nationality picklist value ,import getObjectInfo,getPicklistValues
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import Cricketer_Object from "@salesforce/schema/Cricketers__c";
import Nationality_Field from "@salesforce/schema/Cricketers__c.Nationality__c";

export default class PlayerSearchFilter extends NavigationMixin(
  LightningElement
) {
  recordTypeId;
  picklistValue;
  optionsArray;
  selectedCricketerNationality = "";
  selectedPlayerId;

  //https://developer.salesforce.com/docs/platform/lwc/guide/reference-wire-adapters-object-info.html

  @wire(getObjectInfo, { objectApiName: Cricketer_Object })
  objectInfos({ data, error }) {
    if (error) {
      console.log("error:" + JSON.stringify(error));
    } else if (data) {
      this.recordTypeId = data.defaultRecordTypeId; //We need to grt the defaultRecordTypeId of cricket object
      console.log("this.recordTypeId:" + JSON.stringify(this.recordTypeId));
    }
  }

  //https://developer.salesforce.com/docs/platform/lwc/guide/reference-wire-adapters-picklist-values.html
  //Whenever we do call using wire method and in parameter we need to send
  //some values then mention it in string format and append $
  @wire(getPicklistValues, {
    recordTypeId: "$recordTypeId",
    fieldApiName: Nationality_Field
  })
  nationalityFieldValues({ data, error }) {
    if (error) {
      console.log("error:" + JSON.stringify(error));
    } else if (data) {
      let arr = [];
      this.picklistValue = data.values;
      console.log("picklist data:" + JSON.stringify(this.picklistValue));

      this.picklistValue.forEach((element) => {
        arr.push({ label: element.value, value: element.value });
      });
      this.optionsArray = arr;
      console.log(" this.optionsArray:" + JSON.stringify(this.optionsArray));
    }
  }
  //On click of New Cricketer button show the form og cricket obj record cretion.
  createCricketer() {
    this[NavigationMixin.Navigate]({
      type: "standard__objectPage", //it is a custom object but still pass standard__objectPage

      attributes: {
        objectApiName: "Cricketers__c",
        actionName: "new"
      }
    });
  }
  handleOptionChange(event) {
    this.selectedCricketerNationality = event.detail.value;
    console.log(
      "this.selectedCricketerNationality:" +
        JSON.stringify(this.selectedCricketerNationality)
    );

    this.template
      .querySelector("c-player-search-results")
      .searchCricketer(this.selectedCricketerNationality);
  }

  handleCustomEvent(event) {
    this.selectedPlayerId = event.detail.playerId;
    console.log(
      "this.selectedPlayerId in parent LWC:" +
        JSON.stringify(this.selectedPlayerId)
    );
  }
}