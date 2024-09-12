import { LightningElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";

export default class NavigationLwcDemo extends NavigationMixin(
  LightningElement
) {
  handleClickNavigation() {
    // //navigate to Tab
    // this[NavigationMixin.Navigate]({
    //   type: "standard_navItemPage",
    //   attributes: {
    //     apiName: "Player_Explorer"
    //   }
    // });

    //    Navigate to Account object recent filter
    // this[NavigationMixin.Navigate]({
    //   type: "standard_objectPage",
    //   attributes: {
    //     objectApiName: "Account",
    //     actionName: "list"
    //   },

    //   state: {
    //     filterName: "00B2w000005Ttx3EAC"
    //   }
    // });

    // create the new account record page
    // this[NavigationMixin.Navigate]({
    //   type: "standard__objectPage",
    //   attributes: {
    //     objectApiName: "Account",
    //     actionName: "new"
    //   }
    // });
    // view custom Object record
    // this[NavigationMixin.Navigate]({
    //   type: "standard__recordPage",
    //   attributes: {
    //     recordId: "0012w00001cVHyaAAG",
    //     objectApiName: "Account",
    //     actionName: "view"
    //   }
    // });

    // this[NavigationMixin.Navigate]({
    //   type: "standard__recordPage",
    //   attributes: {
    //     recordId: "0012w00001cVHyaAAG",
    //     objectApiName: "Account",
    //     actionName: "edit"
    //   }
    // });
    //Navigate to URL
    // this[NavigationMixin.Navigate]({
    //   type: "standard__webPage",
    //   attributes: {
    //     url: "https://www.youtube.com/"
    //   }
    // });
    //open one or more file record
    this[NavigationMixin.Navigate]({
      type: "standard__namedPage",
      attributes: {
        pageName: "filePreview"
      },

      state: {
        recordIds: "0692w00000EfAYnAAN",
        selectedRecordId: "0692w00000EfAYnAAN"
      }
    });
  }
}