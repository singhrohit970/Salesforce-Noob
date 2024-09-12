({
  myAction: function (component, event, helper) {
    component.find("childLwc").callMe();
  }
});