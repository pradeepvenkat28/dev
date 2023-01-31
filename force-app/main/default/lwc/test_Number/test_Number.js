import { LightningElement,track } from 'lwc';
nunValue;
export default class Test_Number extends LightningElement {

    handleInputChange(event) {
        this.nunValue = event.detail.value;

        console.log(nunValue);
    }
}