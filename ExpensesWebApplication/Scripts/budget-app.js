
/* TODO - Adjust this so there is a AppViewBridge.js and a AppBusinessStrategy.js */

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
function cloneCard(caller, className, parentClassName, classToRemove) {
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
    newSection.find(`.${classToRemove}`).each(function (index, hiddenNode) {
        hiddenNode.className = hiddenNode.className.replace(`${classToRemove}`, "");
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

