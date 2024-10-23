import { LightningElement } from 'lwc';

export default class SayHello extends LightningElement {

  name;

  handleClick() {
    console.log('You clicked the button');
    this.name = this.template.querySelector('lightning-input').value;
    console.log(this.name);
  }


}