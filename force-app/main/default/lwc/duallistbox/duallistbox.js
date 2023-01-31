import { LightningElement } from 'lwc';
export default class Duallistbox extends LightningElement {
    value = 'inProgress';
    _selected;
    get listOptions() {
        if(this.value=='inProgress'){
        return Object.values( [
        { value: '1', label: 'Option 1' },
        { value: '2', label: 'Option 2' },
        { value: '3', label: 'Option 3' },
        { value: '4', label: 'Option 4' },
        { value: '5', label: 'Option 5' },
        { value: '6', label: 'Option 6' },
        { value: '7', label: 'Option 7' },
        { value: '8', label: 'Option 8' },
    ]);}else if(this.value=='new'){

        return Object.values( [
            { value: '11', label: 'Option 11' },
            { value: '12', label: 'Option 12' },
            { value: '13', label: 'Option 13' },
            { value: '14', label: 'Option 14' },
            { value: '15', label: 'Option 15' },
            { value: '16', label: 'Option 16' },
            { value: '17', label: 'Option 17' },
            { value: '18', label: 'Option 18' },
        ]);
    }


}

    get defaultOptions() {
        if(this.value=='inProgress'){return Object.values(['7', '2', '3']);}
        else if(this.value =='new')
        {return Object.values(['11', '12', '13']);}
    }
        

    get requiredOptions() {
        if(this.value=='inProgress'){return Object.values([ '12', '17']);}
        else if(this.value =='new')
        {return Object.values([ '12', '17']);}
    }

    handleChange(event) {
        // Get the list of the "value" attribute on all the selected options
        const selectedOptionsList = event.detail.value;
        this._selected = event.detail.value;
        alert(`Options selected: ${selectedOptionsList}`);
    }

    

    get options() {
        return [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
    }

    handleChangeCombo(event) {
        this.value = event.detail.value;

    }
}