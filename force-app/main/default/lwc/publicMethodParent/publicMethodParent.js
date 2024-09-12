import { LightningElement, track } from "lwc";

export default class PublicMethodParent extends LightningElement {
  @track value;
  checkboxSelectHandler() {
    //getting the child so that we can make call to the child component method
    const childComponent = this.template.querySelector("c-public-method-child");
    //calling the method of child componenet in parent component
    const returnedMessage = childComponent.selectCheckbox(this.value);
    console.log("Returned Message ", returnedMessage);
  }

  onInputChangeHandler(event) {
    this.value = event.target.value;
    console.log("this.value " + this.value);
  }
}