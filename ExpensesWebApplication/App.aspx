﻿<%@ Page Title="DashBudget" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="App.aspx.cs" Inherits="ExpensesWebApplication.App" %>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContentPlaceHolder" runat="server">
    <%: Scripts.Render("~/bundles/budget-view-facade") %>
    <%: Scripts.Render("~/bundles/budget-strategy") %>
    <script type="text/javascript">
        const budgetStrategy = new BudgetStrategy();
        const budgetViewFacade = new BudgetViewFacade(budgetStrategy);
    </script>
    <webopt:bundlereference runat="server" path="~/App/css" />
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- TODO - Replace all of this to React --> 
    <main>
        <section>
            <h1 id="aspnetTitle">Average Budget Report</h1>
            <p>Input all of your income and expenses to calculate your average net profit. The more information, the more accurate.</p>
            <table class="money-breakdown">
                <tr>
                    <td>
                        <span>Average Subtotal Monthly Income</span>
                    </td>
                    <td>
                        <span class="subtotal-income"><%=GetValueInMoneyFormat(balanceModel.SubtotalIncome)%></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>Average Subtotal Monthly Variable Income</span>
                    </td>
                    <td>
                        <span class="subtotal-monthly-variable-income"><%=GetValueInMoneyFormat(balanceModel.SubtotalVariableIncome)%></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>Average Subtotal Monthly Expenses</span>
                    </td>
                    <td>
                        <span class="subtotal-monthly-expenses"><%=GetValueInMoneyFormat(balanceModel.SubtotalExpenses)%></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>Average SubTotal Monthly Variable Expenses</span>
                    </td>
                    <td>
                        <span class="subtotal-monthly-variable-expenses"><%=GetValueInMoneyFormat(balanceModel.SubtotalVariableExpenses)%></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>Average Monthly Net Profit</span>
                    </td>
                    <td>
                        <span class="total-monthly-net-profit"><%=GetValueInMoneyFormat(balanceModel.NetProfit)%></span>
                    </td>
                </tr>
            </table>
        </section>

        <section class="income-wrapper">
            <h2>
                Income 
                <!-- TODO - Add listeners for the button actions instead. --> 
                <input class="btn btn-default add-button" onclick="budgetViewFacade.cloneCard(this, 'income-card', 'income-wrapper', 'hidden')" type="button" value="+"/>
            </h2>

            <%  
                int i = 0; 
                foreach (ExpensesLibrary.Expense income in balanceModel.IncomeList)
                { 
                    %>
                    <div class="income-card record">
                        <div>
                            <input name="IncomeName_<%=i%>" type="text" class="income-name name" value="<%=income.Name%>" onchange="budgetViewFacade.recalculate()" />
                            <input class="btn btn-default remove-button <%=(i > 0) ? "" : "hidden"%>" onclick="budgetViewFacade.removeCard(this)" type="button" value="X"/>
                        </div>
                        <input type="text" name="IncomeDescription_<%=i%>" class="income-desc description" value="<%=income.Description%>" onchange="budgetViewFacade.recalculate()" />
                        <div>
                            <input type="text" name="IncomeCost_<%=i%>" class="income-cost cost" value="<%=GetValueInMoneyFormat(income.Cost)%>" onchange="budgetViewFacade.recalculate()" />
                            <select onchange="budgetViewFacade.recalculate()" name="IncomeFrequency_<%=i%>" class="frequency" >
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
                    <%      
                    i++; 
               } 
            %>
        </section>
        
        <section class="variable-income-wrapper">
            <h2>
                Variable Income
                <input class="btn btn-default add-button" onclick="budgetViewFacade.cloneCard(this, 'variable-income-card', 'variable-income-wrapper', 'hidden')" type="button" value="+"/>
            </h2>

            <% 
                i = 0;
                foreach (ExpensesLibrary.VariableExpense variableIncome in balanceModel.VariableIncomeList)
                { 
                    %>
                    <div class="variable-income-card record">
                        <div>
                            <input type="text" class="variable-income-name" value="<%=variableIncome.Name%>" />
                            <input class="btn btn-default remove-button <%=(i > 0) ? "" : "hidden"%>" onclick="budgetViewFacade.removeCard(this)" type="button" value="X"/>
                        </div>
                        <input type="text" class="variable-income-desc description" value="<%=variableIncome.Description%>" />
                        <div>
                            <span class="income-monthly"><%=GetValueInMoneyFormat(GetMonthlyCost(variableIncome))%></span>
                            <span>Monthly</span>
                        </div>
                        <div class="variable-income-line-list">
                            <% 
                                int j = 0;
                                foreach(ExpensesLibrary.VariableExpenseLine variableIncomeLine in variableIncome.VariableExpenseLineList )
                                { 
                                    %>
                                    <div class="variable-income-line">
                                        <input type="text" class="variable-income-line-cost cost" value="<%=GetValueInMoneyFormat(variableIncomeLine.Cost)%>" onchange="budgetViewFacade.recalculate()" />
                                        <input type="date" class="variable-income-line-date date" value="<%=GetValueInDateFormat(variableIncomeLine.Date)%>" onchange="budgetViewFacade.recalculate()" />
                                        <!-- TODO - Replace all these inline onclicks with callbacks stored in a functional layer. -->
                                        <input class="btn btn-default remove-button <%=(j > 0) ? "" : "hide-line"%>" onclick="budgetViewFacade.removeVariableLine(this, 'variable-income-line')" type="button" value="X"/>
                                    </div>
                                    <%
                                    j++;
                                } 
                            %>
                            <input class="btn btn-default add-button" onclick="budgetViewFacade.cloneCard(this, 'variable-income-line', 'variable-income-card', 'hide-line')" type="button" value="+"/>
                        </div>
                    </div>
                    <%
                    i++;
                } 
            %>
        </section>
        <section class="expenses-wrapper">
            <h2>
                Expenses
                <input class="btn btn-default add-button" onclick="budgetViewFacade.cloneCard(this, 'expense-card', 'expenses-wrapper', 'hidden')" type="button" value="+"/>
            </h2>

            <% 
                i = 0;
                foreach (ExpensesLibrary.Expense expense in balanceModel.ExpenseList)
                { 
                    %>
                    <div class="expense-card record">
                        <div>
                            <input type="text" name="ExpenseName_<%=i%>" class="expense-name name" value="<%=expense.Name%>" />
                            <input class="btn btn-default remove-button <%=(i > 0) ? "" : "hidden"%>" onclick="budgetViewFacade.removeCard(this)" type="button" value="X"/>
                        </div>
                        <input type="text" name="ExpenseDescription_<%=i%>" class="expense-desc description" value="<%=expense.Description%>" onchange="budgetViewFacade.recalculate()" />
                        <div>
                            <input type="text" name="ExpenseCost_<%=i%>" class="expense-cost cost" value="<%=GetValueInMoneyFormat(expense.Cost)%>" onchange="budgetViewFacade.recalculate()" />
                            <select onchange="budgetViewFacade.recalculate()" class="frequency" >
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
                    <%      
                    i++;
               } %>
        </section>
        
        <section class="variable-expenses-wrapper">
            <h2>
                Variable Expenses
                <input class="btn btn-default add-button" onclick="budgetViewFacade.cloneCard(this, 'variable-expense-card', 'variable-expenses-wrapper', 'hidden')" type="button" value="+"/>
            </h2>

            <% 
                i = 0;
                foreach (ExpensesLibrary.VariableExpense variableExpense in balanceModel.VariableExpenseList)
                { 
                    %>
                    <div class="variable-expense-card record">
                        <div>
                            <input type="text" class="variable-expense-name" value="<%=variableExpense.Name%>" />
                            <input class="btn btn-default remove-button <%=(i > 0) ? "" : "hidden"%>" onclick="budgetViewFacade.removeCard(this)" type="button" value="X"/>
                        </div>
                        <input type="text" class="variable-expense-desc description" value="<%=variableExpense.Description%>" />
                        <div>
                            <span class="expense-monthly"><%=GetValueInMoneyFormat(GetMonthlyCost(variableExpense))%></span>
                            <span>Monthly</span>
                        </div>
                        <div class="variable-expense-line-list">
                            <% 
                                int j = 0;
                                foreach(ExpensesLibrary.VariableExpenseLine variableExpenseLine in variableExpense.VariableExpenseLineList )
                                { 
                                    %>
                                    <div class="variable-expense-line">
                                        <input type="text" class="variable-expense-line-cost cost" value="<%=GetValueInMoneyFormat(variableExpenseLine.Cost)%>" onchange="budgetViewFacade.recalculate()" />
                                        <input type="date" class="variable-expense-line-date date" value="<%=GetValueInDateFormat(variableExpenseLine.Date)%>" onchange="budgetViewFacade.recalculate()" />
                                        <input class="btn btn-default remove-button <%=(j > 0) ? "" : "hide-line"%>" onclick="budgetViewFacade.removeVariableLine(this, 'variable-expense-line')" type="button" value="X"/>
                                    </div>
                                    <% 
                                    j++;
                                } 
                            %>
                            <input class="btn btn-default add-button" onclick="budgetViewFacade.cloneCard(this, 'variable-expense-line', 'variable-expense-card', 'hide-line')" type="button" value="+"/>
                        </div>
                    </div>
                    <%
                    i++;
                } 
            %>
        </section>

    </main>

</asp:Content>
