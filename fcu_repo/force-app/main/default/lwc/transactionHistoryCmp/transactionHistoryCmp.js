import { LightningElement, track,api , wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, getRecordNotifyChange } from 'lightning/uiRecordApi';
import { TRANSACTION_HISTORY_LABELS } from "c/transactionsLabelsUtil";
import getTransactionList from '@salesforce/apex/TransactionHistoryController.getContactList';
 
const columns = [
    { label: 'Transaction Reference Number', fieldName: 'TransactionReferenceNumber',wrapText: true },
    { label: 'Transaction Amount', fieldName: 'TransactionAmount', type: 'string',wrapText: true },
    { label: 'Transaction Type', fieldName: 'DebitCredit',wrapText: true },
    { label: 'Post Date', fieldName: 'PostDate', type: 'string',wrapText: true },
    { label: 'Effective Date', fieldName: 'EffectiveDate', type: 'string', sortable: true,wrapText: true },
];

export default class TransactionHistoryCmp extends LightningElement {

    transactionHistoryLabels = TRANSACTION_HISTORY_LABELS;

    @api recordId;
    @api objectApiName;

    @track isLoading=false;
    @track isSelectTransactionsByDateRange=false;
    @track isRecordsAvailable = true;
    @track TransactionTypeValueSelected='';
    @track NoOfTrnsactionValueSelected='10';
    @track FromDateValueSelected;
    @track ToDateValueSelected;
    //@track startDateValue='';
    @track startDateValue='';
    @track endDateValue='';
    @track totalTransactions=0;
    todayDate=new Date().toISOString().slice(0,10);
    sortedBy;
    defaultSortDirection = 'desc';
    sortDirection = 'desc';

    get TransactionType() {
        return [
            { label: 'All', value: ' ' },
            { label: 'Debit', value: 'D' },
            { label: 'Credit', value: 'C' },
        ];
    }

    get NumberOfTransaction() {
        return [
            { label: '5', value: '5' },
            { label: '10', value: '10' },
            { label: '15', value: '15' },
            { label: '20', value: '20' },
            { label: '25', value: '25' },
            { label: '30', value: '30' },
            { label: '35', value: '35' },
            { label: '40', value: '40' }
        ];
    }

    showToast(){
        this.isLoading = true;
        this.records = [];
        
        console.log('true/false: '+this.NoOfTrnsactionValueSelected != '0' || (this.startDateValue != '' && this.endDateValue != ''));
        console.log(this.startDateValue+' : '+this.endDateValue);
        console.log('this.NoOfTrnsactionValueSelected : '+this.NoOfTrnsactionValueSelected);
         
    }

    handleTransactionByDateRangeOrNoOfTransactions(event) {
        this.isSelectTransactionsByDateRange=event.target.checked;

        if (this.isSelectTransactionsByDateRange == false) {
            this.startDateValue='';
            this.endDateValue='';
            this.NoOfTrnsactionValueSelected='10';
        } else {
            this.startDateValue='';
            this.endDateValue='';
            this.NoOfTrnsactionValueSelected='';
        }
    }

    columns = columns;
    @track isTrue=false;
    @track records=[];
    @track error;

    @track errorMsg;

    handleGetTransaction(){
        console.log(this.startDateValue+' : '+this.endDateValue);
        if(this.TransactionTypeValueSelected === ''){
                    
            this.isTrue=false;
            this.showToastMessages('error', 'Please select type of transaction');
            this.isLoading = false;
            return false;
        }
        if(this.isSelectTransactionsByDateRange==true && this.startDateValue === ''){
                    
            this.isTrue=false;
            this.showToastMessages('error', 'Please select Start Date.');
            this.isLoading = false;
            return false;
        }
        if(this.isSelectTransactionsByDateRange==true && this.endDateValue === ''){
                    
            this.isTrue=false;
            this.showToastMessages('error', 'Please select End Date.');
            this.isLoading = false;
            return false;
        }       



        getTransactionList({'financialAccountRecordId' : this.recordId, 'noOfTxns':this.NoOfTrnsactionValueSelected, 'txnsType':this.TransactionTypeValueSelected, 'StartDate':this.startDateValue,'EndDate':this.endDateValue})
        .then(result =>{
            window.console.log('---TransactionTypeValueSelected--'+this.TransactionTypeValueSelected+'--trnsno--'+this.NoOfTrnsactionValueSelected);
           
            this.records = result;
            if(this.records != null){
                this.isTrue=true;
                this.isRecordsAvailable = true;
                this.showToastMessages('success', this.transactionHistoryLabels.transactionHistoryRetievedSuccessfully);
            }else{
                this.isTrue=false;
                this.isRecordsAvailable = false;
                this.showToastMessages('success', this.transactionHistoryLabels.transactionsAreNotAvailable);
            }
            
            window.console.log('---test--'+JSON.stringify(result));
            window.console.log(this.records.length);
            window.console.log('resp: '+result);
            console.log('---113--'+JSON.stringify(records, null, '\t'));
        })
        .catch(error =>{
            window.console.log('---error--'+JSON.stringify(error));
            this.errorMsg = error;
        })
    }
    

    showToastMessages(varient, message) {
        this.dispatchEvent(new ShowToastEvent({
            title: varient.charAt(0).toUpperCase()+varient.slice(1)+'!!',
            message: message,
            variant: varient
        }),);
    }

    resetHistory(){
        this.isLoading = true;
        this.template.querySelectorAll('lightning-input')
            .forEach(element => { element.value = ''; });
        
        this.TransactionTypeValueSelected='';
        this.NoOfTrnsactionValueSelected='10';
        this.isSelectTransactionsByDateRange = false;
        this.template.querySelector("lightning-input[data-my-id=dateRangeCheckboxId]").checked = false;
        this.startDateValue='';
        this.endDateValue='';
        this.isTrue=false;
        this.isLoading = false;
    }

    handleChange(event) {
        const labelOf=event.target.label;

        console.log(labelOf);
        if(labelOf===this.transactionHistoryLabels.transactionType) {
            this.TransactionTypeValueSelected = event.target.value;
            console.log('TransactionTypeValueSelected: '+this.TransactionTypeValueSelected)
        }
        if(labelOf===this.transactionHistoryLabels.selectNoOfTransations) {
            this.NoOfTrnsactionValueSelected = event.target.value;
            console.log('NoOfTrnsactionValueSelected: '+this.NoOfTrnsactionValueSelected)
            console.log(this.recordId)
        }
        if(labelOf===this.transactionHistoryLabels.transactionEndDate) {
            this.endDateValue = event.target.value;
            console.log('endDateValue: '+this.endDateValue)
        }
        if(labelOf===this.transactionHistoryLabels.transactionStartDate) {
            this.startDateValue = event.target.value;
            console.log('startDateValue: '+this.startDateValue)
        }     
    }

    onHandleSort( event ) {

        this.sortedBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortBy(event.detail.fieldName,event.detail.sortDirection);
    }

    sortBy( fieldName, sortDirection ) {

        let sortResult = [...this.records];
        let parser = (v) => v;
        let column = this.columns.find(c=>c.fieldName===fieldName);
        if(column.type==='date' || column.type==='datetime') {
          parser = (v) => (v && new Date(v));
        }
        let sortMult = sortDirection === 'asc'? 1: -1;
        this.records = sortResult.sort((a,b) => {
          let a1 = parser(a[fieldName]), b1 = parser(b[fieldName]);
          let r1 = a1 < b1, r2 = a1 === b1;
          return r2? 0: r1? -sortMult: sortMult;
        });
    }
}