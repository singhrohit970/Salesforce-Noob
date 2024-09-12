import { LightningElement, api } from "lwc";

export default class ChildLwc extends LightningElement {
  // handleSubtratct() {
  //   this.dispatchEvent(new CustomEvent("subtract"));
  // }
  // handleAdd() {
  //   this.dispatchEvent(new CustomEvent("add"));
  // }
  // handleMultiply(event) {
  //   const valueForMultiply = event.target.value;
  // alert("valueForMultiply" + valueForMultiply);
  //   this.dispatchEvent(
  //     new CustomEvent("multiply", {
  //       detail: valueForMultiply
  //     })
  //   );
  // }

  @api counter = 0;
  @api maximizeCounter() {
    //  this.counter = this.counter+100;
    this.counter += 100;
  }
}