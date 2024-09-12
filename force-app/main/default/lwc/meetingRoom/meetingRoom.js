import { LightningElement, api } from "lwc";

export default class MeetingRoom extends LightningElement {
  @api meetingRoomInfo = { roomName: "A-001", roomCapacity: "12" };

  @api showRoomInfo = false;

  tileClickHandler() {
    //to fire an event from LWC we need to use dispatch event method which is part of standard javascript
    const tileClicked = new CustomEvent("tileclick", {
      detail: this.meetingRoomInfo,
      bubbles: true
    });
    this.dispatchEvent(tileClicked);
  }
}