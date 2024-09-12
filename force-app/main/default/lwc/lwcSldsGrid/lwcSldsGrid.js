import { LightningElement } from "lwc";

export default class LwcSldsGrid extends LightningElement {
  //create array of object for storing imgurl
  data = [
    {
      id: 1,
      imgLink:
        "https://cdn.britannica.com/25/222725-050-170F622A/Indian-cricketer-Mahendra-Singh-Dhoni-2011.jpg"
    },

    {
      id: 2,
      imgLink:
        "https://blogassets.leverageedu.com/blog/wp-content/uploads/2020/10/01190618/Virat-Kohli-Height-Weight-Age-Wife-Family-Affair.jpg"
    },

    {
      id: 3,
      imgLink:
        "https://i.pinimg.com/564x/f6/4e/7b/f64e7bc0b4c1e14fdbac8093f0643b25.jpg"
    },
    {
      id: 4,
      imgLink: "https://im.rediff.com/cricket/2023/oct/19virat.png?w=670&h=900"
    }
  ];
}