import { LightningElement, wire ,track,api } from 'lwc';

import { getRecord } from 'lightning/uiRecordApi';

import getproducts from '@salesforce/apex/Productswrapper.getproducts';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//import Quantity from '@salesforce/schema/OpportunityLineItem.Quantity';

import passdata from '@salesforce/apex/oppproduct.saveproducts';

export default class AddProducts extends LightningElement {

    @api recordId;

    @track opportunity;

    errors;

    @track columns = [

       // { label: 'id', fieldName: 'Product2Id'},

        { label: 'Name', fieldName: 'Name' },

        { label: 'List Price', fieldName: 'UnitPrice'},

        {label: 'Family', fieldName: 'Fam'}

    ];

    @track columns1 = [

      //{ label: 'id', fieldName: 'Product2Id' },

      { label: 'Name', fieldName: 'Name' },

      { label: 'List Price', fieldName: 'UnitPrice',editable:true},

      { label: 'Quantity', fieldName: 'Quantity', editable: true},

  ];

   @track ProductList;

   @track Products=false;

   //Method 2

   connectedCallback(){

   getproducts({recid:this.recordId})

   .then(result => {

       this.ProductList = result;

   })

   .catch(error => {

       this.error = error;

   });

      }

   showModalBox() {  

    this.Products = true;

    this.opportunity = false;




  }

  closeModalBox() {  

    this.Products = false;

    //var a = document.getElementById('slds-modal slds-fade-in-open');

    //a.style.display = 'none';

  }

  //onselect(){

   // this.opportunity = true;

   // this.Products = false;

    //var a = document.getElementById('slds-modal slds-fade-in-open');

   // a.style.display = 'none';

 // }

  deselect(){

    this.opportunity = false;

    this.Products = false;

   /**var a = this.template.querySelector('slds-modal slds-fade-in-open');

    a.style.display = 'none';

    var a = this.template.querySelector('slds-modal slds-fade-in-open1');

    a.style.display = 'none';**/

  }

  errortoastmessage(){

    const evt = new ShowToastEvent({

      title: 'Toast Error',

      message: 'Quantity cannont be empty,Fill Quantity for each products',

      variant: 'error',

      mode: 'dismissable'

  });

  this.dispatchEvent(evt);

  }

  Onselect(){

    this.opportunity = true;

    this.Products = false;

    var selectedRows =  this.template.querySelector("lightning-datatable").getSelectedRows();

    console.log(

      'selectedRows are ',

      JSON.stringify( selectedRows )

  );

   

  if (selectedRows) {

         this.opportunity  = selectedRows;

         




    } else if (error) {

    console.log(error);

    }

  }

  handlesave(event){

    var savevalues=event.detail.draftValues;

    //var temp=JSON.stringify(this.opportunity);

   // var allval=event.detail.data.UnitPrice;

    console.log('record id',this.recordId);

  this.savevalues=JSON.stringify(savevalues);

  console.log('before sorting values',this.savevalues);

  this.savevalues=savevalues.sort((a, b) => (a.Product2Id > b.Product2Id) ? 1: -1);

  console.log('before sorting values',this.savevalues);

  console.log('opp length',this.opportunity.length);

  console.log('draft length',savevalues.length);

  if(savevalues.length<this.opportunity.length){

    this.errortoastmessage();

  }

  else{

    var qlength=0;

  for(var k=0;k<savevalues.length;k++){

    if(savevalues[k]['Quantity'] != null){

         qlength++;

    }

  }

  console.log('qlength',qlength);

  if(qlength<savevalues.length){

    this.errortoastmessage();

  }else{

 var j=0;

 for (var i = 0; i < savevalues.length; i++) {

  var proid=savevalues[i]['Product2Id'];

  var quan=savevalues[i]['Quantity'];

  var unit=savevalues[i]['UnitPrice'];

  if(savevalues[i]['UnitPrice'] == null){

    var unit=this.opportunity[j].UnitPrice;

  }

  else{

    var unit=savevalues[i]['UnitPrice'];  

  }

    //this.proid=savevalues[i]['Product2Id'];

    //this.quan=this.savevalues[i]['Quantity'];

    console.log(i);

    console.log('prodid values',proid);

    console.log('quan values',quan);

    console.log('quan values',unit);

    console.log(j);

    console.log('before values',this.opportunity[j].UnitPrice);

    //console.log('listvalue',this.temp[j]['UnitPrice']);

   j++;

    //console.log('product6 values',this.quan);

   passdata({pro:proid,quan:quan,recordId:this.recordId,unit:unit});

}

const evt = new ShowToastEvent({

  title: 'Success',

  message: 'All Products are added',

  variant: 'success',

  mode: 'dismissable'

});

this.dispatchEvent(evt);

this.deselect();

setTimeout(() => {

  eval("$A.get('e.force:refreshView').fire();");

}, 1000);

  }

}

//setTimeout(function () { (window.location.reload()) }.bind(this), 4000);

  }

}