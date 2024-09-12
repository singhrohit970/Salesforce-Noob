import { LightningElement, wire ,api} from 'lwc';
import getCricketerList from '@salesforce/apex/ContactClassController.getCricketerList'
import {publish,MessageContext} from 'lightning/messageService';
import SELECTED_PLAYER_CHANNEL from '@salesforce/messageChannel/SelectedPlayer__c';

export default class PlayerSearchResults extends LightningElement {

    cricketersNationality = "";
    cricketersData;
    selectedPlayerId;

    @wire(getCricketerList,{nationality :'$cricketersNationality'})
    wiredCricketers({ error, data }) {

        if (error) {
            console.error(error);

        } else if (data) {
            this.cricketersData = data;
            console.log("this.cricketersData:" + JSON.stringify(this.cricketersData))
        }
    }

    @wire(MessageContext)
    messageContext;

    handleClickPlayerCard(event) {
        this.selectedPlayerId = event.currentTarget.dataset.id;
        console.log("this.selectedPlayerId:" + JSON.stringify(this.selectedPlayerId))
      //publish selected player id to LMS channel 
        publish(this.messageContext , SELECTED_PLAYER_CHANNEL,{cricketerId: this.selectedPlayerId})
        let boxClass = this.template.querySelectorAll('.selected');

        if (boxClass.length > 0) {
            this.removeClass();
        }

        // current selected player card details
        let playerBox = this.template.querySelector('[data-id="${this.selectedPlayerId}"]');
        if (playerBox) {
            playerBox.className = 'title_wrapper selected';
        }

        // custom event firing to parent

        this.dispatchEvent(new CustomEvent('select',{
            detail:{
                playerId : this.selectedPlayerId
            }
        }))

    }
    removeClass() {
        this.template.querySelectorAll('.selected')[0].classList.remove('selected');
    }

    @api searchCricketer(nationalityOfCricketer){
    console.log('Value in child LWC: '+JSON.stringify(nationalityOfCricketer));
    this.cricketersNationality = nationalityOfCricketer;
    }

}