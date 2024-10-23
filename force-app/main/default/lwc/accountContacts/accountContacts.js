import { LightningElement, api, track, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import getContacts from "@salesforce/apex/AccountContactsController.getContacts";
import NAME_FIELD from "@salesforce/schema/Account.Name";

export default class AccountContacts extends LightningElement {
  
  @api recordId;
  @track selectedCustomers = [];

  /*contacts = {
    data: [
      { Id: 1, Name: "Contact 1" },
      { Id: 2, Name: "Contact 2" }
    ]
  };*/

  get countOfSelected() {
    return this.selectedCustomers.length;
  }

  @wire(getContacts, { accountId: "$recordId" })
  contacts;

  @wire(getRecord, { recordId: "$recordId", fields: [NAME_FIELD]})
  account;

  get accountName() {
    return getFieldValue(this.account.data, NAME_FIELD);
  }
  
  handleCustomerToggle(event) {
    console.log(JSON.stringify(event.detail));
    let selected = this.selectedCustomers;
    if (event.detail.selected) {
      selected.push(event.detail.id);
    } else {
      selected = selected.filter(s => s !== event.detail.id);
    }
    this.selectedCustomers = selected;
  }

}
