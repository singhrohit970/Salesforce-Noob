import { LightningElement } from "lwc";

export default class ParentLwc extends LightningElement {
  startCounter = 0;

  handleStartChange(event) {
    this.startCounter = parseInt(event.target.value);
  }

  handleMaximizeCounter() {
    // const updateCounter =this.template.querySelector('c-child-lwc');
    //updateCounter.maximizeCounter();

    this.template.querySelector("c-child-lwc").maximizeCounter();
  }
  //countValue = 0;
  // handleDecrement() {
  //   this.countValue--;
  // }
  // handleIncrement() {
  //   this.countValue++;
  // }
  // handleMultiply(event) {
  //   const multiplyingNumber = event.detail;
  // alert("multiplyingNumber:" + multiplyingNumber);
  // this.countValue= this.countValue*multiplyingNumber;
  //this.countValue *= multiplyingNumber;
  //}
}