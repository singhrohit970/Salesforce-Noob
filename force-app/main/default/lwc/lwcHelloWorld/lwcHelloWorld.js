import { LightningElement, api } from "lwc";

export default class LwcHelloWorld extends LightningElement {
  @api name;

  @api
  callMe() {
    console.log("#####Hello World");
  }
}