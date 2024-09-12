import { LightningElement,api,wire } from 'lwc';
import {getRecord, getFieldValue} from 'lightning/uiRecordApi';


const Name ='Pokemon__c.Name';
const LATITUDE ='Pokemon__c.Location__Latitude__s';
const LONGITUDE ='Pokemon__c.Location__Longitude__s';

const pokemonField=[Name,LATITUDE,LONGITUDE];


export default class PokemonLocation extends LightningElement {


    @api recordId;
    mapMakers=[];
    name;
    cardTitle;


    @wire(getRecord,{recordId : '$recordId', fields:pokemonField})
    getPokemons({error,data}){

        if(error){
            console.error('Error:'+JSON.stringify(error))
        }else if(data){
            this.name=getFieldValue(data, Name);
            this.cardTitle = this.name;

            const Latitude = getFieldValue(data, LATITUDE);
            const Longitude = getFieldValue(data , LONGITUDE);
           //array of object
            this.mapMarkers =[{

                location : {Latitude , Longitude},
                title : this.name,
                description: `Coords : ${Latitude}, ${Longitude}` 
            }]
            console.log("This.mapMakers:" +JSON.stringify(this.mapMarkers))
        }
        }
    }