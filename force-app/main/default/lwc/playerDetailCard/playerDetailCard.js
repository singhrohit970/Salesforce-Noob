import { LightningElement,wire } from 'lwc';
import{subscribe,MessageContext} from 'lightning/messageService';
import SELECTED_PLAYER_CHANNEL from '@salesforce/messageChannel/SelectedPlayer__c';
import getSelectedPlayerDetail from '@salesforce/apex/ContactClassController.getSelectedPlayerDetail';
import {NavigationMixin} from 'lightning/navigation';
export default class PlayerDetailCard extends NavigationMixin(LightningElement) {

selectedPlayerId;
cricketerData;
    @wire(MessageContext)
    messageContext;

    connectedCallback(){

        subscribe(
        this.messageContext,
        SELECTED_PLAYER_CHANNEL,
        (message) =>{
            console.log('message from LMS:' +JSON.stringify(message));
            this.handleSelectedCricketer(message.cricketerId);
            }
        )
    }
    handleSelectedCricketer(cricketerId){
    this.selectedPlayerId =cricketerId;

    getSelectedPlayerDetail({playerId:this.selectedPlayerId})
    .then(result=>{
        this.cricketerData=result;
     console.log('Selected Player Detail:' +JSON.stringify(result))

    })
    .catch(error=>{
        console.error(error);
    })
}

    handleNavigateToRecord(){

       this[NavigationMixin.Navigate]({
        type:'standard__recordPage',

              attributes:{
                recordId:this.selectedPlayerId,
                objectApiName:'Cricketers__c',
                actionName:'view'
                }
          })
        }
    
}