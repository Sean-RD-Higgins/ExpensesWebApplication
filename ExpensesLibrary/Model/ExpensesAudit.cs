using System;
using System.Collections.Generic;

namespace ExpensesLibrary
{
    // TODO - Add xml summaries with parameters
    // TODO - Explain that is is serializable not just for nosql, but also so if we containerize, we can store the user's current session state.
    [Serializable]
    public class ExpensesAudit
    {
        // TODO - Add xml summaries with parameters
        public IList<Expense> IncomeList { get;  set; }
        // TODO - Add xml summaries with parameters
        public IList<VariableExpense> VariableIncomeList { get; set; }
        // TODO - Add xml summaries with parameters
        public IList<Expense> ExpenseList { get;  set; }
        // TODO - Add xml summaries with parameters
        public IList<VariableExpense> VariableExpenseList { get;  set; }
        // TODO - Add xml summaries with parameters
        public decimal SubtotalIncome { get;  set; }
        // TODO - Add xml summaries with parameters
        public decimal SubtotalVariableIncome { get;  set; }
        // TODO - Add xml summaries with parameters
        public decimal TotalIncome { get; set; }
        // TODO - Add xml summaries with parameters
        public decimal SubtotalExpenses { get;  set; }
        // TODO - Add xml summaries with parameters
        public decimal SubtotalVariableExpenses { get;  set; }
        // TODO - Add xml summaries with parameters
        public decimal TotalExpenses { get;  set; }
        // TODO - Add xml summaries with parameters
        public decimal NetProfit { get;  set; }
    }
}