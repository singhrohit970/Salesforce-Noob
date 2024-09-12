import { LightningElement, wire, track } from 'lwc';
import getPlayerList from '@salesforce/apex/wireDemoBySalesforceNoob.getPlayerList';

const columns = [
    { label: "Name", fieldName: "Name" },
    { label: "Player record id", fieldName: 'Id' },
];
export default class WireDemoBySalesforceNoob extends LightningElement {
    @track columns = columns;
    @track data = [];


    @wire(getPlayerList)
    wiredPlayers({ data, error }) {
        if (data) {
            this.data = data;

        }
        else if (error) {
            console.log("error occured")
        }
    }
}