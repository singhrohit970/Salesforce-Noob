import { LightningElement, wire } from "lwc";
import { getRecord, deleteRecord } from "lightning/uiRecordApi";
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import ACCOUNT_INDUSTRY from "@salesforce/schema/Account.Industry";
import ACCOUNT_PHONE from "@salesforce/schema/Account.Phone";
import ACCOUNT_OWNER from "@salesforce/schema/Account.Owner.Name";

const FIELDS = [ACCOUNT_NAME, ACCOUNT_INDUSTRY, ACCOUNT_PHONE, ACCOUNT_OWNER];
export default class GetAndDeleteRecordWithoutApex extends LightningElement {
  accountDetail;
  accountName;
  industry;
  phone;
  owner;
  accountId;

  //get record without calling APEX

  @wire(getRecord, { recordId: "0012w000028cv2WAAQ", fields: FIELDS })
  wireAccount({ error, data }) {
    if (error) {
      console.error("Error:" + JSON.stringify(error));
    } else if (data) {
      this.accountDetail = data;
      console.log("this.accountDetail:" + JSON.stringify(this.accountDetail));
      console.log("data:" + JSON.stringify(data));
      this.accountId = this.accountDetail.id;
      this.accountName = this.accountDetail.fields.Name.value;
      this.industry = this.accountDetail.fields.Industry.value;
      this.phone = this.accountDetail.fields.Phone.value;
      this.owner = this.accountDetail.fields.Owner.displayValue;
    }
  }

  deleteAccount() {
    deleteRecord(this.accountId)
      .then((result) => {
        window.alert("Record Deleted");
      })
      .catch((error) => {
        console.error("Error:" + JSON.stringify(error));
      });
  }
}