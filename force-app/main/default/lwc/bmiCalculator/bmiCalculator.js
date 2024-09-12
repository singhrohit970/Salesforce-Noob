import { LightningElement, track } from "lwc";

export default class BmiCalculator extends LightningElement {
  cardTitle = "BMI Calculator";

  @track bmiData = {
    weight: 0,
    height: 0,
    result: 0
  };

  // weight;
  // height;

  //bmiCalculator;
  showBMI = false;
  bmiCategory = "";

  //   BMI Categories:
  //   Underweight = <18.5
  //   Normal weight = 18.5–24.9
  //   Overweight = 25–29.9
  //   Obesity = BMI of 30 or greater

  onWeightChange(event) {
    this.bmiData.weight = parseFloat(event.target.value);
  }

  onHeightChange(event) {
    this.bmiData.height = parseFloat(event.target.value);
  }

  calculateBMI() {
    try {
      this.bmiData.result =
        this.bmiData.weight / (this.bmiData.height * this.bmiData.height);
    } catch (error) {
      this.bmiData.result = undefined;
    }
    this.bmiData.result = Math.min(
      50,
      Math.max(1, this.bmiData.result.toFixed(1))
    );
    this.evaluateBMI();
  }

  evaluateBMI() {
    if (this.bmiData.result < 18.5) {
      this.bmiCategory = "Underweight";
    } else if (this.bmiData.result >= 18.5 && this.bmiData.result <= 24.9) {
      this.bmiCategory = "Normal weight";
    } else if (this.bmiData.result >= 25 && this.bmiData.result <= 29.9) {
      this.bmiCategory = "Overweight";
    } else {
      this.bmiCategory = "Obesity";
    }
  }

  get bmiValue() {
    if (this.bmiData.result === undefined) {
      return "";
    }
    return `Your BMI is: ${this.bmiData.result}`;
  }
}