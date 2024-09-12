import { LightningElement } from 'lwc';

export default class LwcRefsDemo extends LightningElement {

    handleChanges(){
    let para=this.refs.myText;
    para.className='red_text';
    }

    handleChildlwc(){
        // parent to child call old method or child component calling
        //this.template.querySelector('c-lwc-child').sayHi();

        //latest how we can use lwc ref for calling
       // this.refs.myChildLwc.sayHi(); or we can use below way 
       let childLwc = this.refs.myChildLwc;
       childLwc.sayHi();
    }
}