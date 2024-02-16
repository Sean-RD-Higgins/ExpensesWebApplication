<%@ Page Title="DashExpense" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="App.aspx.cs" Inherits="ExpensesWebApplication.App" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        /* TODO - Move this to a site css file */
        .cost {
            width: 5em;
        }
        .description {
            width: 20em;
            font-size: 10px;
        }
        .add-button {
            background-color: lightgreen;
            font-weight: bolder;
            border: 1px solid black;
            
        }
        .remove-button {
            background-color: lightcoral;
            font-weight: bolder;   
            margin: 0.1em 0em;
        }
        .record {
          background-color: #BFDFDF;
          padding: 0.5em 1em;
          margin: 0.5em 0;
          display: inline-block;
        }
        .name {
            width: 10em;
        }
        .money-breakdown td {
            font-family: 'Courier New';
            text-align: right;
            border: 1px solid black;
        }
        .record {
            vertical-align: top;
        }
        section {
            margin: 2em 0;
        }
    </style>
    <script type="text/javascript">
        /* TODO - Move this to a site js file */

        /*
            To those reviewing this. Yes, there are established libraries that handle cards better.
            In a production environment, we are advocates of using the libraries instead of coding them ourselves.
            However, the purpose of this exercise is to display our problem solving skills.
        */

        const AVERAGE_DAYS_IN_A_MONTH_FLOAT = 30.437;
        const AVERAGE_DAYS_IN_A_MONTH_DECIMAL = 30.437;
        const DAYS_IN_A_WEEK_FLOAT = 7.0;
        const MONTHS_IN_A_YEAR_DECIMAL = 12.0;
        const MONTHS_IN_A_HALFYEAR_DECIMAL = 6.0;
        const AVERAGE_WEEKS_PER_MONTH_DECIMAL = 4.345;
        const AVERAGE_BIWEEKS_PER_MONTH_DECIMAL = 4.345 / 2;

        /*
            TODO - Move all of this and the references to a Strategy Pattern.
        */

        /*
            TODO - Add XML Summaries and param summaries.
            TODO - Rename to recalculate.
        */
        function autoSave() {
            let incomeCardList = $('.income-card');
            let totalIncome = 0.0;
            for (i = 0; i < incomeCardList.length; i++) {
                let incomeCard = incomeCardList[i];
                let incomeMonthly = $('.income-monthly', incomeCard);
                let cost = parseFloat($('.cost', incomeCard).val());
                let frequency = $('.frequency', incomeCard).val();
                let monthlySum = GetMonthlySum(cost, frequency);
                totalIncome += monthlySum;
                incomeMonthly.text(monthlySum.toFixed(2));
            }

            let variableIncomeCardList = $('.variable-income-card');
            let subtotalVariableIncome = 0.0;
            for (i = 0; i < variableIncomeCardList.length; i++) {
                let variableIncomeCard = variableIncomeCardList[i];
                let lineList = $('.variable-income-line', variableIncomeCard);
                let dateList = [];
                let variableIncomeTotal = 0.0;
                for (j = 0; j < lineList.length; j++) {
                    let line = lineList[j];
                    let cost = parseFloat($('.cost', line).val());
                    let dateText = $('.date', line).val();
                    let date = Date.parse(dateText);
                    variableIncomeTotal += cost;
                    dateList.push(date);
                }
                let monthlyIncome = GetMonthlyCost(variableIncomeTotal, dateList);
                subtotalVariableIncome += monthlyIncome;
                let incomeMonthly = $('.income-monthly', variableIncomeCard);
                incomeMonthly.text(monthlyIncome.toFixed(2));
            }

            let expenseCardList = $('.expense-card');
            let subtotalExpenses = 0.0;
            for (i = 0; i < expenseCardList.length; i++) {
                let incomeCard = expenseCardList[i];
                let incomeMonthly = $('.expense-monthly', incomeCard);
                let cost = parseFloat($('.cost', incomeCard).val());
                let frequency = $('.frequency', incomeCard).val();
                let monthlyExpenses = GetMonthlySum(cost, frequency);
                subtotalExpenses += monthlyExpenses;
                incomeMonthly.text(monthlyExpenses.toFixed(2));
            }

            let variableExpenseCardList = $('.variable-expense-card');
            let subtotalVariableExpenses = 0.0;
            for (i = 0; i < variableExpenseCardList.length; i++) {
                let variableExpenseCard = variableExpenseCardList[i];
                let lineList = $('.variable-expense-line', variableExpenseCard);
                let dateList = [];
                let variableExpenseTotal = 0.0;
                for (j = 0; j < lineList.length; j++) {
                    let line = lineList[j];
                    let cost = parseFloat($('.cost', line).val());
                    let dateText = $('.date', line).val();
                    let date = Date.parse(dateText);
                    variableExpenseTotal += cost;
                    dateList.push(date);
                }
                let monthlyExpenses = GetMonthlyCost(variableExpenseTotal, dateList);
                subtotalVariableExpenses += monthlyExpenses;
                let expenseMonthly = $('.expense-monthly', variableExpenseCard);
                expenseMonthly.text(monthlyExpenses.toFixed(2));
            }

            $('.subtotal-income').text(totalIncome.toFixed(2));
            $('.subtotal-monthly-variable-income').text(subtotalVariableIncome.toFixed(2));
            $('.subtotal-monthly-expenses').text(subtotalExpenses.toFixed(2));
            $('.subtotal-monthly-variable-expenses').text(subtotalVariableExpenses.toFixed(2));
            $('.total-monthly-net-profit').text((totalIncome + subtotalVariableIncome - subtotalExpenses - subtotalVariableExpenses).toFixed(2));
        }

        /*
            TODO - Add XML Summaries and param summaries.
        */
        function removeCard(caller) {
            $(caller).closest('.record').remove();
            autoSave();
        }

        /*
            TODO - Add XML Summaries and param summaries.
        */
        function cloneCard(caller, className, parentClassName) {
            var repeatingGroup = [];
            var currentCaller = caller;
            for (var i = 0; i < 5; i++) {
                currentCaller = currentCaller.parentElement;
                repeatingGroup = $(`.${className}`, currentCaller);
                if (repeatingGroup.length > 0) {
                    break;
                }
            }
            if (repeatingGroup.length == 0) {
                return false;
            }
            var currentIndex = repeatingGroup.length - 1;
            var newIndex = repeatingGroup.length;
            var lastRepeatingGroup = repeatingGroup.last();
            var newSection = lastRepeatingGroup.clone();
            newSection.insertAfter(lastRepeatingGroup);
            newSection.find("input").each(function (index, input) {
                input.name = input.name.replace("_" + currentIndex, "_" + newIndex);
            });
            newSection.find("select").each(function (index, input) {
                input.name = input.name.replace("_" + currentIndex, "_" + newIndex);
            });
            autoSave();
            return false;
        }

        /*
            TODO - Add XML Summaries and param summaries.
        */
        function removeVariableLine(caller, className) {
            $(caller).closest(`.${className}`).remove();
            autoSave();
        }


        /*
            TODO - Add XML Summaries and param summaries.
        */
        function GetMonthlySum(cost, frequency) {
            switch (frequency) {
                case 'Daily':
                    return cost * AVERAGE_DAYS_IN_A_MONTH_DECIMAL;
                case 'Weekly':
                    return cost * AVERAGE_WEEKS_PER_MONTH_DECIMAL;
                case 'BiWeekly':
                    return cost * AVERAGE_BIWEEKS_PER_MONTH_DECIMAL;
                case 'Monthly':
                    return cost;
                case 'HalfAnnually':
                    return cost / MONTHS_IN_A_HALFYEAR_DECIMAL;
                case 'Annually':
                    return cost / MONTHS_IN_A_YEAR_DECIMAL;
            }
        }

        /*
            TODO - Add XML Summaries and param summaries.
        */
        function GetMonthlyCost(totalCost, dateList) {
            return GetDailyCost(totalCost, dateList) * AVERAGE_DAYS_IN_A_MONTH_DECIMAL;
        }

        /*
            TODO - Add XML Summaries and param summaries.
        */
        function GetDailyCost(totalCost, dateList) {
            if (dateList.length <= 1) {
                return totalCost;
            }
            let minDate = Date.parse('12/12/2099');
            let maxDate = Date.parse('1/1/2000');
            const oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
            dateList.forEach((date) => {
                minDate = date < minDate ? date : minDate;
                maxDate = date > maxDate ? date : maxDate;
            });

            // Date padding is needed because if you don't have it, it will inflate the numbers by accident.
            // Short Example:
            // Consider expenses on days /01 /03 /05
            // A person would say the pattern is /01 /03 /05 /07 /09 /11
            // However, Average logic will say you get paid twice in a 3 day span and thus...
            // It would be /01 /03 /05 /06 /08 /10
            // And thus data padding is required.
            // Longer example:
            // one would assume the next expenses would be on /07 /09 /11  right?
            // [Get Paid][Wait][Get Paid][Wait][Get Paid][WAIT][Get Paid][Wait][Get Paid][Wait][Get Paid]
            // but with this base average logic in place, it would assume the next set of expenses are /06 /08 /10
            // [Get Paid][Wait][Get Paid][Wait][Get Paid][GET PAY AGAIN][Wait][Get Paid][Wait][Get Paid]
            // This is because the logic calculates the average cost between first and last day
            // It assumes that you will begin paying again on the day RIGHT AFTER the last day.
            // When in reality, in this example, there is a single day BREAK between expenses.
            let differenceInDateTime = maxDate - minDate;
            let averageBreakInDays = differenceInDateTime / dateList.length;
            differenceInDateTime += averageBreakInDays;
            const diffDays = Math.round(Math.abs(differenceInDateTime / oneDay));
            let dailyCost = totalCost / diffDays;
            return dailyCost;
        }


    </script>

    <!-- TODO - Replace all of this with a modern MVC framework --> 
    <main>
        <section>
            <h1 id="aspnetTitle">Balance Report</h1>
            <table class="money-breakdown">
                <tr>
                    <td>
                        <span>Subtotal Monthly Income</span>
                    </td>
                    <td>
                        <span class="subtotal-income">+<%=GetValueInMoneyFormat(balanceModel.SubtotalIncome)%></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>Subtotal Monthly Variable Income</span>
                    </td>
                    <td>
                        <span class="subtotal-monthly-variable-income">+<%=GetValueInMoneyFormat(balanceModel.SubtotalVariableIncome)%></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>Subtotal Monthly Expenses</span>
                    </td>
                    <td>
                        <span class="subtotal-monthly-expenses">-<%=GetValueInMoneyFormat(balanceModel.SubtotalExpenses)%></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>SubTotal Monthly Variable Expenses</span>
                    </td>
                    <td>
                        <span class="subtotal-monthly-variable-expenses">-<%=GetValueInMoneyFormat(balanceModel.SubtotalVariableExpenses)%></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>Monthly Net Profit</span>
                    </td>
                    <td>
                        <span class="total-monthly-net-profit">=<%=GetValueInMoneyFormat(balanceModel.NetProfit)%></span>
                    </td>
                </tr>
            </table>
        </section>

        <section class="income-wrapper">
            <h2>
                Income 
                <a class="btn btn-default add-button" onclick="cloneCard(this, 'income-card', 'income-wrapper')">+</a>
            </h2>

            <% int i = 0; foreach (ExpensesLibrary.Expense income in balanceModel.IncomeList)
                { %>
                    <div class="income-card record">
                        <div>
                            <input name="IncomeName_<%=i%>" type="text" class="income-name name" value="<%=income.Name%>" onchange="autoSave()" />
                            <a class="btn btn-default remove-button" onclick="removeCard(this)">X</a>
                        </div>
                        <input type="text" name="IncomeDescription_<%=i%>" class="income-desc description" value="<%=income.Description%>" onchange="autoSave()" />
                        <div>
                            <input type="text" name="IncomeCost_<%=i%>" class="income-cost cost" value="<%=GetValueInMoneyFormat(income.Cost)%>" onchange="autoSave()" />
                            <select onchange="autoSave()" name="IncomeFrequency_<%=i%>" class="frequency" >
                                <% foreach(ExpensesLibrary.Frequency frequency in Enum.GetValues(typeof(ExpensesLibrary.Frequency)) )
                                   { %>
                                        <option 
                                            <% if (income.Frequency == frequency) { %>
                                                    selected="selected"
                                            <% } %>
                                            value='<%=Enum.GetName(typeof(ExpensesLibrary.Frequency), frequency) %>'
                                        >
                                            <%=Enum.GetName(typeof(ExpensesLibrary.Frequency), frequency) %>
                                        </option>
                                <% } %>
                            </select>
                        </div>
                        <% if (income.Frequency != ExpensesLibrary.Frequency.Monthly)
                           { %>
                                <div>
                                    <span class="income-monthly"><%=GetValueInMoneyFormat(GetMonthlySum(income))%></span>
                                    <span>Monthly</span>
                                </div>
                        <% } %>
                    </div>
            <%      i++; 
               } %>
        </section>
        
        <section class="variable-income-wrapper">
            <h2>
                Variable Income
                <a class="btn btn-default add-button" onclick="cloneCard(this, 'variable-income-card', 'variable-income-wrapper')">+</a>
            </h2>

            <% foreach (ExpensesLibrary.VariableExpense variableIncome in balanceModel.VariableIncomeList)
                { %>
                    <div class="variable-income-card record">
                        <div>
                            <input type="text" class="variable-income-name" value="<%=variableIncome.Name%>" />
                            <a class="btn btn-default remove-button" onclick="removeCard(this)">X</a>
                        </div>
                        <input type="text" class="variable-income-desc description" value="<%=variableIncome.Description%>" />
                        <div>
                            <span class="income-monthly"><%=GetValueInMoneyFormat(GetMonthlyCost(variableIncome))%></span>
                            <span>Monthly</span>
                        </div>
                        <div class="variable-income-line-list">
                            <% foreach(ExpensesLibrary.VariableExpenseLine variableIncomeLine in variableIncome.VariableExpenseLineList )
                                { %>
                                    <div class="variable-income-line">
                                        <input type="text" class="variable-income-line-cost cost" value="<%=GetValueInMoneyFormat(variableIncomeLine.Cost)%>" onchange="autoSave()" />
                                        <input type="date" class="variable-income-line-date date" value="<%=GetValueInDateFormat(variableIncomeLine.Date)%>" onchange="autoSave()" />
                                        <!-- TODO - Replace all these inline onclicks with callbacks stored in a functional layer. -->
                                        <a class="btn btn-default remove-button" onclick="removeVariableLine(this, 'variable-income-line')">X</a>
                                    </div>
                            <% } %>
                            <a class="btn btn-default add-button" onclick="cloneCard(this, 'variable-income-line', 'variable-income-card')">+</a>
                        </div>
                    </div>
            <% } %>
        </section>
        <section class="expenses-wrapper">
            <h2>
                Expenses
                <a class="btn btn-default add-button" onclick="cloneCard(this, 'expense-card', 'expenses-wrapper')">+</a>
            </h2>

            <% foreach (ExpensesLibrary.Expense expense in balanceModel.ExpenseList)
               { %>
                    <div class="expense-card record">
                        <div>
                            <input type="text" name="ExpenseName_<%=i%>" class="expense-name name" value="<%=expense.Name%>" />
                            <a class="btn btn-default remove-button" onclick="removeCard(this)">X</a>
                        </div>
                        <input type="text" name="ExpenseDescription_<%=i%>" class="expense-desc description" value="<%=expense.Description%>" onchange="autoSave()" />
                        <div>
                            <input type="text" name="ExpenseCost_<%=i%>" class="expense-cost cost" value="<%=GetValueInMoneyFormat(expense.Cost)%>" onchange="autoSave()" />
                            <select onchange="autoSave()" class="frequency" >
                                <% foreach(ExpensesLibrary.Frequency frequency in Enum.GetValues(typeof(ExpensesLibrary.Frequency)) )
                                    { %>
                                        <option 
                                            <% if (expense.Frequency == frequency) { %>
                                                    selected="selected"
                                            <% } %>
                                            value='<%=Enum.GetName(typeof(ExpensesLibrary.Frequency), frequency) %>'
                                        >
                                            <%=Enum.GetName(typeof(ExpensesLibrary.Frequency), frequency) %>
                                        </option>
                                <% } %>
                            </select>
                        </div>
                        <% if (expense.Frequency != ExpensesLibrary.Frequency.Monthly)
                           { %>
                                <div>
                                    <span class="expense-monthly"><%=GetValueInMoneyFormat(GetMonthlySum(expense))%></span>
                                    <span>Monthly</span>
                                </div>
                        <%} %>
                    </div>
            <%      i++;
               } %>
        </section>
        
        <section class="variable-expenses-wrapper">
            <h2>
                Variable Expenses
                <a class="btn btn-default add-button" onclick="cloneCard(this, 'variable-expense-card', 'variable-expenses-wrapper')">+</a>
            </h2>

            <% foreach (ExpensesLibrary.VariableExpense variableExpense in balanceModel.VariableExpenseList)
                { %>
                    <div class="variable-expense-card record">
                        <div>
                            <input type="text" class="variable-expense-name" value="<%=variableExpense.Name%>" />
                            <a class="btn btn-default remove-button" onclick="removeCard(this)">X</a>
                        </div>
                        <input type="text" class="variable-expense-desc description" value="<%=variableExpense.Description%>" />
                        <div>
                            <span class="expense-monthly"><%=GetValueInMoneyFormat(GetMonthlyCost(variableExpense))%></span>
                            <span>Monthly</span>
                        </div>
                        <div class="variable-expense-line-list">
                            <% foreach(ExpensesLibrary.VariableExpenseLine variableExpenseLine in variableExpense.VariableExpenseLineList )
                                { %>
                                    <div class="variable-expense-line">
                                        <input type="text" class="variable-expense-line-cost cost" value="<%=GetValueInMoneyFormat(variableExpenseLine.Cost)%>" onchange="autoSave()" />
                                        <input type="date" class="variable-expense-line-date date" value="<%=GetValueInDateFormat(variableExpenseLine.Date)%>" onchange="autoSave()" />
                                        <a class="btn btn-default remove-button" onclick="removeVariableLine(this, 'variable-expense-line')">X</a>
                                    </div>
                            <% } %>
                            <a class="btn btn-default add-button" onclick="cloneCard(this, 'variable-expense-line', 'variable-expense-card')">+</a>
                        </div>
                    </div>
            <% } %>
        </section>

    </main>

</asp:Content>
