import { LightningElement,track } from 'lwc';

export default class TrainingLwc extends LightningElement {
/* fullname="Rohit Singh";
userchecked= false;

    handleclick(event){
        console.log('Rohit before value assignment');
        this.userchecked=event.target.checked; */

        @track collegename=["VIT","VTU","NIT"];


        connectedCallback(){
            console.log('Looping example');
            for(let i=0;i<this.collegename.length;i++){
                console.log('collegename:',this.collegename[i]);
        }
    }
   
}