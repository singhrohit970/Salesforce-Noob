import { LightningElement } from "lwc";
import footballPlayers from "@salesforce/resourceUrl/footballPlayers";
export default class CarouselDemo extends LightningElement {
  //create array of Object whenever we call via wire method or imperative method to jb bhi list return karta h
  // tab hamesha wo array of object form m return karta h

  //agar ek player ka data show karna h to ek object create karna padega
  //do object ka to do create karna padega

  //apex m id ek unique identifier h. we can use here for each object.
  //jb bhi object create karte ho property k end m colon dena padta h

  players = [
    {
      id: "1",
      header: "Neymar",
      src: footballPlayers + "/sf_Noob_Image/Ronaldo.jpeg",
      href: "https://en.wikipedia.org/wiki/Neymar",
      description: "Neymar Jr"
    },

    {
      id: "2",
      header: "Ronaldo",
      src: footballPlayers + "/sf_Noob_Image/Ronaldo.jpeg",
      href: "https://en.wikipedia.org/wiki/Neymar",
      description: "Neymar Jr"
    },

    {
      id: "3",
      header: "Messi",
      src: footballPlayers + "/sf_Noob_Image/Ronaldo.jpeg",
      href: "https://en.wikipedia.org/wiki/Neymar",
      description: "Neymar Jr"
    }
  ];
}