import { LightningElement, api } from "lwc";

export default class AccountContactRow extends LightningElement {
  @api contact;
  selected = false;

  handleChangeSelected() {
    this.selected = !this.selected;
    let toggle = new CustomEvent("toggle", {
      detail: {
        selected: this.selected,
        id: this.contact.Id
      }
    });
    this.dispatchEvent(toggle);
  }
}
