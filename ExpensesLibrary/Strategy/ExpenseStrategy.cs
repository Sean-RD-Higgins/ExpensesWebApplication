using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExpensesLibrary.Strategy
{
    // TODO - Add xml summaries with parameters
    public class ExpenseStrategy
    {

        // TODO - Add xml summaries with parameters
        const float AVERAGE_DAYS_IN_A_MONTH_FLOAT = 30.42f;
        const decimal AVERAGE_DAYS_IN_A_MONTH_DECIMAL = 30.42m;
        const float DAYS_IN_A_WEEK_FLOAT = 7.0f;
        const decimal MONTHS_IN_A_YEAR_DECIMAL = 12.0m;
        const decimal MONTHS_IN_A_HALFYEAR_DECIMAL = 6.0m;
        const decimal AVERAGE_WEEKS_PER_MONTH_DECIMAL = 30.42m / 7.0m;
        const decimal AVERAGE_BIWEEKS_PER_MONTH_DECIMAL = 30.42m / 14.0m;

        // TODO - These are default values, retrieve the actual list from the database after login. 
        public IList<Expense> GetIncomeList()
        {
            return new List<Expense>()
            {
                new Expense() { Name = "Paycheck", Description = "After Taxes", Cost = 1000.0m, Frequency = Frequency.BiWeekly },
                new Expense() { Name = "Savings Interest", Description = "Savings account monthly accrument of interest.", Cost = 0.01m, Frequency = Frequency.Weekly },
            };
        }

        // TODO - These are default values, retrieve the actual list from the database after login. 
        public IList<Expense> GetExpenseList()
        {
            return new List<Expense>()
            {
                new Expense() { Name = "Rent", Description = "Need a place to sleep", Cost = 600.0m, Frequency = Frequency.Monthly },
                new Expense() { Name = "Credit Card Payoff", Description = "This doesn't disappear by itself.", Cost = 20.0m, Frequency = Frequency.Weekly },
                new Expense() { Name = "Internet", Description = "With Verizon Fios", Cost = 60.0m, Frequency = Frequency.Monthly },
                new Expense() { Name = "Wireless", Description = "With Mint Mobile", Cost = 15.0m, Frequency = Frequency.Monthly },
            };
        }

        // TODO - These are default values, retrieve the actual list from the database after login. 
        public IList<VariableExpense> GetVariableExpenseList()
        {
            return new List<VariableExpense>() {
                new VariableExpense() {
                    Name = "Electricity", Description = "Changes every month.",
                    VariableExpenseLineList = new List<VariableExpenseLine>() {
                        new VariableExpenseLine() { Cost = 153.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT) },
                        new VariableExpenseLine() { Cost = 148.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 2) },
                        new VariableExpenseLine() { Cost = 183.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 3) },
                        new VariableExpenseLine() { Cost = 151.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 4) },
                        new VariableExpenseLine() { Cost = 176.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 5) },
                        new VariableExpenseLine() { Cost = 149.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 6) },
                        new VariableExpenseLine() { Cost = 152.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 7) },
                        new VariableExpenseLine() { Cost = 140.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 8) },
                        new VariableExpenseLine() { Cost = 167.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 9) },
                        new VariableExpenseLine() { Cost = 183.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 10) },
                        new VariableExpenseLine() { Cost = 162.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 11) },
                    },
                },
                new VariableExpense() {
                    Name = "Automotive Fuel", Description = "Changes every month.",
                    VariableExpenseLineList = new List<VariableExpenseLine>() {
                        new VariableExpenseLine() { Cost = 38.20m, Date = DateTime.Now.AddDays(- DAYS_IN_A_WEEK_FLOAT) },
                        new VariableExpenseLine() { Cost = 42.50m, Date = DateTime.Now.AddDays(- DAYS_IN_A_WEEK_FLOAT * 2) },
                        new VariableExpenseLine() { Cost = 39.10m, Date = DateTime.Now.AddDays(- DAYS_IN_A_WEEK_FLOAT * 3) },
                        new VariableExpenseLine() { Cost = 41.60m, Date = DateTime.Now.AddDays(- DAYS_IN_A_WEEK_FLOAT * 4) },
                    },
                },
            };
        }

        // TODO - These are default values, retrieve the actual list from the database after login. 
        public IList<VariableExpense> GetVariableIncomeList()
        {
            return new List<VariableExpense>() {
                new VariableExpense() {
                    Name = "Tips", Description = "Service with a smile",
                    VariableExpenseLineList = new List<VariableExpenseLine>() {
                        new VariableExpenseLine() { Cost = 61.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT) },
                        new VariableExpenseLine() { Cost = 52.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 2) },
                        new VariableExpenseLine() { Cost = 43.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 3) },
                        new VariableExpenseLine() { Cost = 98.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 4) },
                        new VariableExpenseLine() { Cost = 16.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 5) },
                        new VariableExpenseLine() { Cost = 82.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 6) },
                        new VariableExpenseLine() { Cost = 55.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 7) },
                        new VariableExpenseLine() { Cost = 33.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 8) },
                        new VariableExpenseLine() { Cost = 43.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 9) },
                        new VariableExpenseLine() { Cost = 27.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 10) },
                        new VariableExpenseLine() { Cost = 162.0m, Date = DateTime.Now.AddDays(- AVERAGE_DAYS_IN_A_MONTH_FLOAT * 11) },
                    },
                },
                new VariableExpense() {
                    Name = "Lottery Winnings", Description = "I'll get you one day, Powerball.",
                    VariableExpenseLineList = new List<VariableExpenseLine>() {
                        new VariableExpenseLine() { Cost = 2.20m, Date = DateTime.Now.AddDays(- DAYS_IN_A_WEEK_FLOAT) },
                        new VariableExpenseLine() { Cost = 4.50m, Date = DateTime.Now.AddDays(- DAYS_IN_A_WEEK_FLOAT * 2) },
                        new VariableExpenseLine() { Cost = 1.10m, Date = DateTime.Now.AddDays(- DAYS_IN_A_WEEK_FLOAT * 3) },
                        new VariableExpenseLine() { Cost = 6.60m, Date = DateTime.Now.AddDays(- DAYS_IN_A_WEEK_FLOAT * 4) },
                    },
                },
            };
        }

        // TODO - Add xml summaries with parameters
        public decimal GetDailyCost(VariableExpense variableExpense)
        {
            DateTime minimumDateTime = variableExpense.VariableExpenseLineList.Min(line => line.Date);
            DateTime maximumDateTime = variableExpense.VariableExpenseLineList.Max(line => line.Date);
            TimeSpan differenceInDateTime = maximumDateTime - minimumDateTime;
            decimal costTotal = variableExpense.VariableExpenseLineList.Sum(line => line.Cost);
            decimal dailyCost = costTotal / (decimal)differenceInDateTime.TotalDays;
            return dailyCost;
        }

        // TODO - Add xml summaries with parameters
        public decimal GetMonthlyCost(VariableExpense variableExpense)
        {
            return GetDailyCost(variableExpense) * AVERAGE_DAYS_IN_A_MONTH_DECIMAL;
        }

        // TODO - Add xml summaries with parameters
        public decimal GetMonthlyTotalExpenses()
        {
            var incomeList = GetIncomeList();
            var expenseList = GetExpenseList();
            var variableExpenseList = GetVariableExpenseList();
            return GetMonthlyTotalExpenses(incomeList, expenseList, variableExpenseList);
        }

        // TODO - Add xml summaries with parameters
        public decimal GetMonthlySum(Expense income)
        {
            switch (income.Frequency)
            {
                case Frequency.Daily:
                    return income.Cost * AVERAGE_DAYS_IN_A_MONTH_DECIMAL;
                case Frequency.Weekly:
                    return income.Cost * AVERAGE_WEEKS_PER_MONTH_DECIMAL;
                case Frequency.BiWeekly:
                    return income.Cost * AVERAGE_BIWEEKS_PER_MONTH_DECIMAL;
                case Frequency.Monthly:
                    return income.Cost;
                case Frequency.HalfAnnually:
                    return income.Cost / MONTHS_IN_A_HALFYEAR_DECIMAL;
                case Frequency.Annually:
                    return income.Cost / MONTHS_IN_A_YEAR_DECIMAL;
                default:
                    throw new NotImplementedException();
            }
        }

        // TODO - Add xml summaries with parameters
        public decimal GetMonthlyExpenseTotal(IList<Expense> incomeList)
        {
            var incomeTotal = 0.0m;
            foreach (Expense income in incomeList)
            {
                incomeTotal += GetMonthlySum(income);
            }
            return incomeTotal;
        }

        // TODO - Add xml summaries with parameters
        public decimal GetMonthlyTotalExpenses(IList<Expense> incomeList, IList<Expense> expenseList, IList<VariableExpense> variableExpenseList)
        {
            var incomeTotal = GetMonthlyExpenseTotal(incomeList);
            var expenseSubtotal = GetMonthlyExpenseTotal(expenseList);
            var variableExpenseSubtotal = variableExpenseList.Sum(ex => GetMonthlyCost(ex));
            var expenseTotal = expenseSubtotal + variableExpenseSubtotal;
            return GetMonthlyTotalExpenses(incomeTotal, expenseTotal);
        }

        // TODO - Add xml summaries with parameters
        public decimal GetMonthlyTotalExpenses(decimal income, decimal expenses)
        {
            return income - expenses;
        }

        // TODO - Add xml summaries with parameters
        public ExpensesAudit GetBalanceModel()
        {
            ExpensesAudit balanceModel = new ExpensesAudit()
            {
                IncomeList = GetIncomeList(),
                VariableIncomeList = GetVariableIncomeList(),
                ExpenseList = GetExpenseList(),
                VariableExpenseList = GetVariableExpenseList(),
            };
            balanceModel.SubtotalIncome = GetMonthlyExpenseTotal(balanceModel.IncomeList);
            balanceModel.SubtotalVariableIncome = balanceModel.VariableIncomeList.Sum(ex => GetMonthlyCost(ex));
            balanceModel.TotalIncome = balanceModel.SubtotalIncome + balanceModel.SubtotalVariableIncome;
            balanceModel.SubtotalExpenses = GetMonthlyExpenseTotal(balanceModel.ExpenseList);
            balanceModel.SubtotalVariableExpenses = balanceModel.VariableExpenseList.Sum(ex => GetMonthlyCost(ex));
            balanceModel.TotalExpenses = balanceModel.SubtotalExpenses + balanceModel.SubtotalVariableExpenses;
            balanceModel.NetProfit = balanceModel.TotalIncome - balanceModel.TotalExpenses;
            return balanceModel;
        }

        // TODO - Add xml summaries with parameters
        public string GetValueInMoneyFormat(decimal inputMoney)
        {
            return string.Format("{0:0.00}", inputMoney);
        }

        // TODO - Add xml summaries with parameters
        public string GetValueInDateFormat(DateTime inputDate)
        {
            return string.Format("{0:yyyy-MM-dd}", inputDate);
        }
    }
}
