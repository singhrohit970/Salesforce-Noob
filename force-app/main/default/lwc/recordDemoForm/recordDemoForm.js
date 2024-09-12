import { LightningElement, track } from "lwc";
import NAME_FIELD from "@salesforce/schema/Players__c.Name";
import EMAIL_FIELD from "@salesforce/schema/Players__c.Email__c";
import GOALS_FIELD from "@salesforce/schema/Players__c.Goals__c";
import CLUB_FIELD from "@salesforce/schema/Players__c.Football_Club__c";
import PLAYER_OBJECT from "@salesforce/schema/Players__c";

export default class RecordDemoForm extends LightningElement {
  @track fields = [NAME_FIELD, EMAIL_FIELD, GOALS_FIELD, CLUB_FIELD];
  objectApiName = PLAYER_OBJECT;

  recordId = "a062w00000XEFnpAAH";
}