import transactionDetails from '@salesforce/label/c.TransactionDetails';
import transactionEndDate from '@salesforce/label/c.TransactionEndDate';
import reset from '@salesforce/label/c.TransactionHistory';
import getTransactionHistoryBySelectedDateRange from '@salesforce/label/c.TransactionHistoryBySelectedDateRange';
import transactionHistoryRetievedSuccessfully from '@salesforce/label/c.TransactionHistoryRetievedSuccessfully';
import submit from '@salesforce/label/c.TransactionHistorySubmit';
import transactionsAreNotAvailable from '@salesforce/label/c.TransactionsAreNotAvailable';
import selectNoOfTransactionsOrDateRange from '@salesforce/label/c.TransactionsSelectNoOfTransactionsOrDateRange';
import selectNoOfTransations from '@salesforce/label/c.TransactionsSelectNoOfTransations';
import transactionStartDate from '@salesforce/label/c.TransactionStartDate';
import transactionType from '@salesforce/label/c.TransactionType';
import endDateShouldBeGreater from '@salesforce/label/c.TransactionEndDateValidation';

const TRANSACTION_HISTORY_LABELS = {
    transactionDetails: transactionDetails,
    transactionEndDate: transactionEndDate,
    //transationHistory: transationHistory,
    getTransactionHistoryBySelectedDateRange: getTransactionHistoryBySelectedDateRange,
    transactionHistoryRetievedSuccessfully: transactionHistoryRetievedSuccessfully,
    submit: submit,
    reset: reset,
    transactionsAreNotAvailable: transactionsAreNotAvailable,
    selectNoOfTransactionsOrDateRange: selectNoOfTransactionsOrDateRange,
    selectNoOfTransations: selectNoOfTransations,
    transactionStartDate: transactionStartDate,
    transactionType: transactionType,
    endDateShouldBeGreater: endDateShouldBeGreater
};


export {TRANSACTION_HISTORY_LABELS}