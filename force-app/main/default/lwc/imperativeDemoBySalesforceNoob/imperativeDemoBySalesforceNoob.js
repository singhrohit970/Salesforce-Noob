import { LightningElement ,track} from 'lwc';
import getPlayerList from '@salesforce/apex/imperativeDemoclassBySalesforceNoob.getPlayerList';
const columns =[
    {label: 'Player record id' , fieldName: 'Id'},
    {label: 'Player Name' , fieldName:  'Name'},
];

export default class ImperativeDemoBySalesforceNoob extends LightningElement {

    @track columns = columns;
    @track data=[];

    connectedCallback(){
        getPlayerList()
        .then(result=>{
            this.data = result;
        })
        .catch(error=>{
            console.log("error occured")
        })
    }
}