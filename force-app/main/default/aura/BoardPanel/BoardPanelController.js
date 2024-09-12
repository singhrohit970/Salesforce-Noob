({
    startGame: function (component, event, helper) {
        //access combobox
        let gameModeComboBox = component.find("gamemode"); //pass the aura id

        //access the value of combobox
        let selectedValue = gameModeComboBox.get("v.value");

        //update selectedMode attribute
        component.set("v.selectedMode", selectedValue);


    },

    reshuffleBoard: function (component, event, helper) {
        console.log("Reshuffle boardd is called");
    }

});