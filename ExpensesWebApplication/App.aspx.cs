using ExpensesLibrary;
using ExpensesLibrary.Strategy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExpensesWebApplication
{
    // TODO - Add xml summaries with parameters
    public partial class App : Page
    {

        protected ExpensesAudit balanceModel = new ExpensesAudit();
        readonly ExpenseStrategy expenseStrategy = new ExpenseStrategy();

        // TODO - Add xml summaries with parameters
        protected void Page_Load(object sender, EventArgs e)
        {
            balanceModel = GetBalanceModel();
            if (!IsPostBack)
            {
                // TODO - Retrieve the auto-saved session for the current user as a draft.
            }
            else
            {
                // TODO - Auto-save the session for the current user as a draft
            }

        }

        // TODO - Add xml summaries with parameters
        public ExpensesAudit GetBalanceModel()
        {
            return expenseStrategy.GetBalanceModel();
        }

        // TODO - Add xml summaries with parameters
        public decimal GetMonthlySum(Expense expense)
        {
            return expenseStrategy.GetMonthlySum(expense);
        }

        // TODO - Add xml summaries with parameters
        public decimal GetMonthlyCost(VariableExpense variableExpense)
        {
            return expenseStrategy.GetMonthlyCost(variableExpense);
        }

        // TODO - Add xml summaries with parameters
        public string GetValueInMoneyFormat(decimal inputMoney)
        {
            return expenseStrategy.GetValueInMoneyFormat(inputMoney);
        }

        // TODO - Add xml summaries with parameters
        public string GetValueInDateFormat(DateTime inputDate)
        {
            return expenseStrategy.GetValueInDateFormat(inputDate);
        }
    }
}