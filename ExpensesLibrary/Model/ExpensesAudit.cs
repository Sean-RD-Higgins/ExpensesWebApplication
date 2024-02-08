using System;
using System.Collections.Generic;

namespace ExpensesLibrary
{
    [Serializable]
    public class ExpensesAudit
    {
        public IList<Expense> IncomeList { get;  set; }
        public IList<VariableExpense> VariableIncomeList { get; set; }
        public IList<Expense> ExpenseList { get;  set; }
        public IList<VariableExpense> VariableExpenseList { get;  set; }
        public decimal SubtotalIncome { get;  set; }
        public decimal SubtotalVariableIncome { get;  set; }
        public decimal TotalIncome { get; set; }
        public decimal SubtotalExpenses { get;  set; }
        public decimal SubtotalVariableExpenses { get;  set; }
        public decimal TotalExpenses { get;  set; }
        public decimal NetProfit { get;  set; }
    }
}