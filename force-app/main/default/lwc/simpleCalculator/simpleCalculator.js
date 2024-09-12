import { LightningElement, track } from "lwc";

export default class SimpleCalculator extends LightningElement {
  @track currentResult;
  @track previousResults = [];
  @track showPreviousResults = false;

  firstNumber;
  secondNumber;

  numberChangeHandler(event) {
    const inputBoxName = event.target.label;
    //console.log("inputBoxName: " + inputBoxName);

    if (inputBoxName === "firstNumber") {
      this.firstNumber = event.target.value;
      console.log("this.firstNumber: " + this.firstNumber);
      console.log(typeof this.firstNumber);
    } else if (inputBoxName === "secondNumber") {
      this.secondNumber = event.target.value;
      console.log("this.secondNumber: " + this.secondNumber);
    }
  }
  // HTML textbox always returns a string value, use parseInt() method to convert it into an integer
  addHandler() {
    const firstN = parseInt(this.firstNumber);
    const secondN = parseInt(this.secondNumber);

    // this.currentResult =
    //   "Result of" + firstN + "+" + secondN + "is" + (firstN + secondN);
    this.currentResult = `Result of ${firstN}+ ${secondN} is ${
      firstN + secondN
    }`;
    this.previousResults.push(this.currentResult);
  }

  subHandler() {
    const firstN = parseInt(this.firstNumber);
    const secondN = parseInt(this.secondNumber);

    // this.currentResult =
    //   "Result of" + firstN + "+" + secondN + "is" + (firstN + secondN);
    this.currentResult = `Result of ${firstN}- ${secondN} is ${
      firstN - secondN
    }`;
    this.previousResults.push(this.currentResult);
  }

  multiplyHandler() {
    const firstN = parseInt(this.firstNumber);
    const secondN = parseInt(this.secondNumber);

    // this.currentResult =
    //   "Result of" + firstN + "+" + secondN + "is" + (firstN + secondN);
    this.currentResult = `Result of ${firstN}* ${secondN} is ${
      firstN * secondN
    }`;
    this.previousResults.push(this.currentResult);
  }

  divisionHandler() {
    const firstN = parseInt(this.firstNumber);
    const secondN = parseInt(this.secondNumber);

    // this.currentResult =
    //   "Result of" + firstN + "+" + secondN + "is" + (firstN + secondN);
    this.currentResult = `Result of ${firstN}/ ${secondN} is ${
      firstN / secondN
    }`;
    this.previousResults.push(this.currentResult);
  }

  showPreviousResultToggle(event) {
    this.showPreviousResults = event.target.checked;
  }
}