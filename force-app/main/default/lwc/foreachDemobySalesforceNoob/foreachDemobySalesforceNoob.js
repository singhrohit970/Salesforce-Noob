import { LightningElement,wire,track } from 'lwc';
import getPlayerList from '@salesforce/apex/foreachDemoBySalesforceNoob.getPlayerList'
export default class ForeachDemobySalesforceNoob extends LightningElement {
@track data=[];

    @wire(getPlayerList)
    players;
}