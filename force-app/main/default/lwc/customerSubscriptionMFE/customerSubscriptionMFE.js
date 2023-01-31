import { LightningElement, api, wire } from 'lwc';
import { loadScript} from 'lightning/platformResourceLoader';
import TefCustomerSubscription from "@salesforce/resourceUrl/CustomerSubscription3";
import getCustomSettings from '@salesforce/apex/TEF_CustomSettingHandler.getCustomSettings';

export default class CustomerSubscriptionMFE extends LightningElement {
    //mfe;
    @api recordId;
    @api result;

    customerId;
    brandId;
    brandName;
    serviceProvideId;
    myCustomSettings = {};

    @wire(getCustomSettings, {}) myCustomSettingsWire({data, error}) {
        if(data) {
            console.log('Entering the load');
            
        }
        this.initiateMFE();
    }

    initiateMFE() {
        // Get the customer information
       
            loadScript(this, TefCustomerSubscription).then(() => {
                // Load MFE file
                this.loadMfe(); 
            }).catch(error => console.log('Error in CustomerSubscription: ', error));
      
    }

   

    loadMfe(){

        alert('loading the static resource...');

        console.log('loading the static resource...');
       
    }
}