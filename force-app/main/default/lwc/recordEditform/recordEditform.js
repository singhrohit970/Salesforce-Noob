import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import PLAYER_OBJECT from "@salesforce/schema/Players__c";
import PLAYER_NAME from "@salesforce/schema/Players__c.Name";
import PLAYER_EMAIL from "@salesforce/schema/Players__c.Email__c";
import PLAYER_GOALS from "@salesforce/schema/Players__c.Goals__c";
import PLAYER_CLUB from "@salesforce/schema/Players__c.Football_Club__c";

export default class RecordEditform extends LightningElement {
  ObjectApiName = PLAYER_OBJECT;
  nameField = PLAYER_NAME;
  emailField = PLAYER_EMAIL;
  goalField = PLAYER_GOALS;
  clubField = PLAYER_CLUB;
  playerId = "created player id will be displayed here";

  handleSuccess(event) {
    this.playerId = event.detail.id;
    const events = new ShowToastEvent({
      title: "Succesfull",
      message: "Player Created",
      variant: "success"
    });

    this.dispatchEvent(events);
  }
}