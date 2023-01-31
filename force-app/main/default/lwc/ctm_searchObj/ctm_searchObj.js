import { LightningElement,api,track } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import ctm_searchObject from '@salesforce/apex/ctm_searchObj.ctm_searchObject';
export default class Ctm_searchObj extends LightningElement {
    searchValue = '';
    @api objResult = '';
    eventsList;
    value = '';
    handleSearchKeyword(event) {
        if(event.target.value ===''){
            this.template.querySelector('.slds-combobox').classList.remove('slds-is-open');
            this.value = '';
        }else{
                this.template.querySelector('.slds-combobox').classList.add('slds-is-open');
            }
        this.searchValue = event.target.value;
        if ((this.searchValue.length) > 0) {
            ctm_searchObject({
                    searchKeyword: this.searchValue
                })
                .then(result => { 
                    this.objResult = JSON.stringify(result).replace("[\"","");
                    this.objResult = this.objResult.replace("\"]","");
                    this.objResult = this.objResult.replaceAll("\",\"",",");
                    this.objResult = '[' + this.objResult + ']';
                    this.objResult = this.objResult.replaceAll('\\"','"');
                    this.objResult = JSON.parse(this.objResult);
                })
                .catch(error => {
                   
                    const event = new ShowToastEvent({
                        title: 'Error',
                        variant: 'error',
                        message: error.message
                    });
                    this.dispatchEvent(event);
                });
        } else  if (this.searchValue == ''){
            // fire toast event if input field is blank
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Search text missing',
            });
            this.dispatchEvent(event);
        }

    }
        handlemousedown(event) {
        this.value = event.currentTarget.dataset.name;
        this.searchValue = event.currentTarget.dataset.value;
        //console.log('this.searchValue-->'+this.searchValue);
        const custEvent = new CustomEvent(
            'callpasstoparent', {
                detail: this.value
            });
        this.dispatchEvent(custEvent);
        this.template.querySelector('.slds-combobox').classList.remove('slds-is-open');
    }
}