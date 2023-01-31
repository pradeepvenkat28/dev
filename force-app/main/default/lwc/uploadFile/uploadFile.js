import { LightningElement, api , track} from 'lwc';
import getChilds from '@salesforce/apex/GetChildObjects.getChildSobjects';


export default class UploadFile extends LightningElement {

    @api recordId;
    selectedObjects = [];
   listOptions ;
    defaultOptions = [];
    requiredOptions = [];

    options = [];
       
    
      selectedOptions = [];
    
      handleChangeC(event) {
        this.selectedOptions = event.detail;
      }


    get acceptedFormats() {
        return ['.pdf', '.png','jpeg'];
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        alert('No. of files uploaded : ' + uploadedFiles.length);
    }
    
    handleChange(event) {
        // Get the list of the "value" attribute on all the selected options
        const selectedOptionsList = event.detail.value;
        alert(`Options selected: ${selectedOptionsList}`);
    }

    connectedCallback() {
        
        getChilds({sObjectName : this.recordId})
            .then(result => {
                this.listOptions = result;
                this.options = result;

                console.log(this.listOptions);
            })
            .catch(error => {
                this.error = error;
            });
    }
}
