using System;
using System.Collections.Generic;

namespace ExpensesLibrary
{
    [Serializable]
    public class VariableExpense
    {
        public VariableExpense()
        {
            VariableExpenseLineList = new List<VariableExpenseLine>();
        }

        public string Name { get; set; }
        public string Description { get; set; }
        public IList<VariableExpenseLine> VariableExpenseLineList { get; set; }
    }
}