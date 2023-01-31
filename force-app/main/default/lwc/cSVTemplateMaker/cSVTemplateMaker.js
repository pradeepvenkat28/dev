import { LightningElement} from 'lwc';
const modalColumns = [
    { label: 'Created By', fieldName: 'createdby', hideDefaultActions:'true' },
    { label: 'Fields', fieldName: 'field', hideDefaultActions:'true' }
];
export default class Ctm_csvTemplateMaker extends LightningElement {
    objResult = 'blank';
    fieldResult;
    name;
    openTemplateName;
    isModalOpen = false;
    isOpenTemplateModalOpen = false;
    optionList;
    selectedOption=[];
    modalColumns = modalColumns;
    modalTableData;
    columns;
    passToParent(event){
            this.objResult = event.detail;
        }

    passToParent2(event){
            this.fieldResult = event.detail;
            this.columns = JSON.stringify(this.fieldResult);
            console.log('this.columns-->'+this.columns);
        }

    handleSave(){
           
        }

    captureName(event){
            this.name = event.target.value;
        }

    openModal(){
            this.isModalOpen = true;
        }
    closeModal(){
            this.isModalOpen = false;
        }

    captureOpenTemplateName(event){
            this.openTemplateName = event.target.value;
        }

    handleOpenTemplate(){
            this.selectedOption = this.selectedOption.replaceAll('\'','"');
            this.selectedOption = JSON.parse(this.selectedOption);
            const custEvent = new CustomEvent(
            'fakeevent', {
                detail: this.selectedOption
            });
            this.dispatchEvent(custEvent);
            this.passToParent2(custEvent);
            this.isOpenTemplateModalOpen = false;
    }

    openOpenTemplateModal(){
            this.isOpenTemplateModalOpen = true;
    }
    closeOpenTemplateModal(){
            this.isOpenTemplateModalOpen = false;
    }

   
    handleChange(event) {
        this.selectedOption = event.detail.value;
        let fields = event.detail.value;
        fields = fields.replace('[','');
        fields = fields.replace(']','');
        fields = fields.replaceAll('\'','');
         
        let createdBy = '';
        for(let x in this.optionList){
            if(this.optionList[x].value === event.detail.value){
                createdBy = this.optionList[x]['CreatedBy'];
                break;
            }
        }
        this.modalTableData =  [{field: fields, createdby: createdBy}];
    }

    handleTypeChange(event){
        if(event.detail.value == null || event.detail.value == ''){
            this.objResult = 'blank';
            this.fieldResult = null;
        }
    }
}