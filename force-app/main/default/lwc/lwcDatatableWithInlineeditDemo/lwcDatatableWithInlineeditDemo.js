import { LightningElement ,wire} from 'lwc';
 import getAccount from'@salesforce/apex/TestAccountClass.getAccount'
 import updateAccountDetails from '@salesforce/apex/TestAccountClass.updateAccountDetails'
 import { ShowToastEvent } from "lightning/platformShowToastEvent";


const columns= [

    {label : 'Account Name', fieldName: 'Name', editable:true},
    {label : 'Website', fieldName: 'Website', editable: true},
    {label : 'Phone' , fieldName: 'Phone', editable:true},
]

export default class LwcDatatableWithInlineeditDemo extends LightningElement {

    columns=columns;
    data=[];
    saveDraftValue=[];


    @wire(getAccount)
    accountData(result){
    console.log("result:" +JSON.stringify(result))

    if(result.error){
        this.data=undefined;
    }else if(result.data){
        this.data=result.data;
        console.log(" this.data:" +JSON.stringify( this.data))
    }
}

//save logic
handleSave(event){
    const updatedfield = event.detail.draftValues;
    console.log("updatedfield: "+JSON.stringify(updatedfield))

  updateAccountDetails({accountData: updatedfield})
    .then(result=>{
        console.log(" apex result: "+JSON.stringify(result))

          //show toast message
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Message",
              message: result,
              variant: "brand"
            })
          );
    })
    .catch(error=>{
        console.log("error:" +JSON.stringify(error))
    })
  
}


}