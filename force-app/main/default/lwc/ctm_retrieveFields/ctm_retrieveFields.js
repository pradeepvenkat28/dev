import { LightningElement,api,wire } from 'lwc';
import ctm_searchField from '@salesforce/apex/ctm_searchFields.ctm_searchField';
export default class Ctm_retrieveFields extends LightningElement {
    _selected = [];
    @api objResult;
    fieldResult=[];
    finalOptions = [];
    finalRequiredOptions = [];
    calledFOC = false;
    //isChanged = false;
    @wire(ctm_searchField,{searchObj:'$objResult'}) 
    outcome;

        get option() {
            //console.log('this.objResult-->'+JSON.stringify(this.objResult));
            if(JSON.stringify(this.objResult) == '"blank"'){
            this._selected = [];
            return [{label:'Select Object to see available fields',value:''}];
            
            }
            this.fieldResult = JSON.stringify(this.outcome).replace("{\"data\":[\"","");
            this.fieldResult = this.fieldResult.replace("\"]}","");
            this.fieldResult = this.fieldResult.replaceAll("\",\"",",");
            this.fieldResult = '[' + this.fieldResult + ']';
            this.fieldResult = this.fieldResult.replaceAll('\\"','"');
            try{
            this.finalOptions = JSON.parse(this.fieldResult);
            }catch(err){console.log('error caught-->'+err.detail);}
            //return JSON.stringify(this.finalOptions);
            return this.finalOptions;
    }

  get requiredOptions(){
        this.finalRequiredOptions = [];
        console.log('Inside requiredOptions');
             if(this.finalOptions!=null && this.finalOptions){
             for(let x in this.finalOptions){
                 if(this.finalOptions[x]['required']=='false'){
                     this.finalRequiredOptions.push(this.finalOptions[x]['value']);
                 }
             }
             console.log('finalRequiredOptions'+JSON.stringify(this.finalRequiredOptions));
              return Object.values(this.finalRequiredOptions);                    
             }             
    }

    get selected() {
        return this._selected.length ? this._selected : 'none';
        //return this._selected
    }

    handleChange(event) { 
     
   if((event.detail.value).length !== this.finalRequiredOptions.length)
       {
           event.detail.value = this.finalRequiredOptions;
       }
        //this._selected = event.detail.value;
        console.log('e.detail-->'+JSON.stringify(event.detail.value));
        console.log('this._selected-->'+this._selected);
        const custEvent = new CustomEvent(
            'callpasstoparent2', {
                detail: event.detail
            });
        this.dispatchEvent(custEvent);  
        //event.stopPropagation(); 
    }

    repair(){
        //console.log('Inside Repair');
        let list = this.template.querySelector('lightning-dual-listbox');
        //console.log('list2-->'+list.value);
        for(let x in this.list){
            console.log('x-->'+list[x].value);
        }

        let up = this.template.querySelector('.slds-button')
        //console.log('up-->'+up);
    }
}