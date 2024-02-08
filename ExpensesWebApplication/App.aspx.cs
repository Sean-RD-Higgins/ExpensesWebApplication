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
    public partial class App : Page
    {

        protected ExpensesAudit balanceModel = new ExpensesAudit();
        readonly ExpenseStrategy expenseStrategy = new ExpenseStrategy();

        protected void Page_Load(object sender, EventArgs e)
        {
            balanceModel = GetBalanceModel();
            if (!IsPostBack)
            {

            }
            else
            {

            }

        }

        public ExpensesAudit GetBalanceModel()
        {
            return expenseStrategy.GetBalanceModel();
        }

        public decimal GetMonthlySum(Expense expense)
        {
            return expenseStrategy.GetMonthlySum(expense);
        }

        public decimal GetMonthlyCost(VariableExpense variableExpense)
        {
            return expenseStrategy.GetMonthlyCost(variableExpense);
        }

        public string GetValueInMoneyFormat(decimal inputMoney)
        {
            return expenseStrategy.GetValueInMoneyFormat(inputMoney);
        }

        public string GetValueInDateFormat(DateTime inputDate)
        {
            return expenseStrategy.GetValueInDateFormat(inputDate);
        }
    }
}