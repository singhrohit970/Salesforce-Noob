import { LightningElement, api } from "lwc";
import PLAYER_OBJECT from "@salesforce/schema/Players__c";
import NAME_FIELD from "@salesforce/schema/Players__c.Name";
import EMAIL_FIELD from "@salesforce/schema/Players__c.Email__c";
import GOAL_FIELD from "@salesforce/schema/Players__c.Goals__c";
import CLUB_FIELD from "@salesforce/schema/Players__c.Football_Club__c";

export default class RecordViewForm extends LightningElement {
  nameField = NAME_FIELD;
  emailField = EMAIL_FIELD;
  goalField = GOAL_FIELD;
  clubField = CLUB_FIELD;
  objectApiName = PLAYER_OBJECT;
  @api recordId = "a062w00000XEFnpAAH";
}