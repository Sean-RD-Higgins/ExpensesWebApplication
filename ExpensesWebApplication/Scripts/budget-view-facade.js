
/*
    To those reviewing this. Yes, there are established libraries that handle cards better.
    In a production environment, we are advocates of using the libraries instead of coding them ourselves.
    However, the purpose of this exercise is to display our problem solving skills.
*/


/**
 * Handles the retrieval and setting values within the DOM by class. 
 */
class BudgetViewFacade {
    #budgetStrategy = new BudgetStrategy();

    constructor(budgetStrategy) {
        this.#budgetStrategy = budgetStrategy;
    }

    /**
     * Takes all of the existing income and expends fields and fills out the dashboard with the results.
     */
    recalculate() {
        let incomeCardList = $('.income-card');
        let totalIncome = 0.0;
        for (let i = 0; i < incomeCardList.length; i++) {
            let incomeCard = incomeCardList[i];
            let incomeMonthly = $('.income-monthly', incomeCard);
            let cost = parseFloat($('.cost', incomeCard).val());
            let frequency = $('.frequency', incomeCard).val();
            let monthlySum = this.#budgetStrategy.GetMonthlySum(cost, frequency);
            totalIncome += monthlySum;
            incomeMonthly.text(monthlySum.toFixed(2));
        }

        let variableIncomeCardList = $('.variable-income-card');
        let subtotalVariableIncome = 0.0;
        for (let i = 0; i < variableIncomeCardList.length; i++) {
            let variableIncomeCard = variableIncomeCardList[i];
            let lineList = $('.variable-income-line', variableIncomeCard);
            let dateList = [];
            let variableIncomeTotal = 0.0;
            for (let j = 0; j < lineList.length; j++) {
                let line = lineList[j];
                let cost = parseFloat($('.cost', line).val());
                let dateText = $('.date', line).val();
                let date = Date.parse(dateText);
                variableIncomeTotal += cost;
                dateList.push(date);
            }
            let monthlyIncome = this.#budgetStrategy.GetMonthlyCost(variableIncomeTotal, dateList);
            subtotalVariableIncome += monthlyIncome;
            let incomeMonthly = $('.income-monthly', variableIncomeCard);
            incomeMonthly.text(monthlyIncome.toFixed(2));
        }

        let expenseCardList = $('.expense-card');
        let subtotalExpenses = 0.0;
        for (let i = 0; i < expenseCardList.length; i++) {
            let incomeCard = expenseCardList[i];
            let incomeMonthly = $('.expense-monthly', incomeCard);
            let cost = parseFloat($('.cost', incomeCard).val());
            let frequency = $('.frequency', incomeCard).val();
            let monthlyExpenses = this.#budgetStrategy.GetMonthlySum(cost, frequency);
            subtotalExpenses += monthlyExpenses;
            incomeMonthly.text(monthlyExpenses.toFixed(2));
        }

        let variableExpenseCardList = $('.variable-expense-card');
        let subtotalVariableExpenses = 0.0;
        for (let i = 0; i < variableExpenseCardList.length; i++) {
            let variableExpenseCard = variableExpenseCardList[i];
            let lineList = $('.variable-expense-line', variableExpenseCard);
            let dateList = [];
            let variableExpenseTotal = 0.0;
            for (let j = 0; j < lineList.length; j++) {
                let line = lineList[j];
                let cost = parseFloat($('.cost', line).val());
                let dateText = $('.date', line).val();
                let date = Date.parse(dateText);
                variableExpenseTotal += cost;
                dateList.push(date);
            }
            let monthlyExpenses = this.#budgetStrategy.GetMonthlyCost(variableExpenseTotal, dateList);
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

    /**
     * Removes a .record card the element is contained within.
     * @param {Element} caller The source DOM node element calling the function.
     */
    removeCard(caller) {
        $(caller).closest('.record').remove();
        this.recalculate();
    }

    /**
     * Takes the last card in a section and duplicates it, then adds it to the end of the siblings.
     * @param {Element} caller The source DOM node element.
     * @param {string} className The class name of the element to duplicate.
     * @param @deprecated {string} parentClassName Flagged for removal.
     * @param {string} classToRemove The class name of the element that has the removal functionality.
     * @returns {boolean} True upon successful removal, false upon failure to remove.
     */
    cloneCard(caller, className, parentClassName, classToRemove) {
        var repeatingGroup = [];
        var currentCaller = caller;
        for (let i = 0; i < 5; i++) {
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
        newSection.find(`.${classToRemove}`).each(function (index, hiddenNode) {
            hiddenNode.className = hiddenNode.className.replace(`${classToRemove}`, "");
        });
        this.recalculate();
        return false;
    }

    /**
     * Removes a .record card the element is contained within.
     * @param {Element} caller The source DOM node element calling the function.
     * @param {string} className The class name of the element to remove.
     */
    removeVariableLine(caller, className) {
        $(caller).closest(`.${className}`).remove();
        this.recalculate();
    }
}
