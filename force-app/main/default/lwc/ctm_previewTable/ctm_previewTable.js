import { LightningElement,api } from 'lwc';
export default class Ctm_previewTable extends LightningElement {
    @api fieldResult;
    text='';
    get headers() {

        //console.log('this.fieldResult inside ctm_previewTable-->'+this.fieldResult);
    if(this.fieldResult!=undefined){
        this.text='';
        //console.log('this.fieldResult inside ctm_previewTable-->'+JSON.stringify(this.fieldResult));
            this.text = JSON.stringify(this.fieldResult).replace('{"value":','');
            this.text = this.text.replace('}','');
            this.text = this.text.replace('["','[{"label":"');
            this.text = this.text.replaceAll(',','},{"label":');
            this.text = this.text.replaceAll('"label":','"hideDefaultActions":"true","label":');
            this.text = this.text.replace(']','}]');
            //console.log('before parsing-->'+this.text);
            if(this.text!='[}]'){
                this.text = JSON.parse(this.text);
                return this.text;
            }
            return [{label:"Please select a few fields",hideDefaultActions:"true"}];
    }
    }
}