/** 
 * @description Contains the business logic to handle the numeric calculations of budgets.
 */
class BudgetStrategy {

    static #AVERAGE_DAYS_IN_A_MONTH_DECIMAL = 30.437;
    static #MONTHS_IN_A_YEAR_DECIMAL = 12.0;
    static #MONTHS_IN_A_HALFYEAR_DECIMAL = 6.0;
    static #AVERAGE_WEEKS_PER_MONTH_DECIMAL = 4.345;
    static #AVERAGE_BIWEEKS_PER_MONTH_DECIMAL = 4.345 / 2.0;

    constructor() {

    }


    /**
     * Returns the calculated cost of a single record over the course of "frequency" time.
     * @param {decimal} cost The decimal money value in a single record at a specific frequency.
     * @param {string} frequency How often the occurance of this cost occurs for the income or expense.
     * @returns {decimal} The calculated cost of a single record over the course of "frequency" time.
     */
    GetMonthlySum(cost, frequency) {
        // TODO - change this to enums and ints so the application can be multi-lingual.
        switch (frequency) {
            case 'Daily':
                return cost * BudgetStrategy.#AVERAGE_DAYS_IN_A_MONTH_DECIMAL;
            case 'Weekly':
                return cost * BudgetStrategy.#AVERAGE_WEEKS_PER_MONTH_DECIMAL;
            case 'BiWeekly':
                return cost * BudgetStrategy.#AVERAGE_BIWEEKS_PER_MONTH_DECIMAL;
            case 'Monthly':
                return cost;
            case 'HalfAnnually':
                return cost / BudgetStrategy.#MONTHS_IN_A_HALFYEAR_DECIMAL;
            case 'Annually':
                return cost / BudgetStrategy.#MONTHS_IN_A_YEAR_DECIMAL;
        }
    }

    /**
     * Returns the calculated cost of a single record over the course of an average month's time.
     * @param {decimal} totalCost The accumulated costs of all of the records for variable income/expense.
     * @param {Date[]} dateList The compiled list of each record's timestamp when it occurred. 
     * @returns {decimal} The calculated cost of a single record over the course of an average month's time.
     */
    GetMonthlyCost(totalCost, dateList) {
        return this.GetDailyCost(totalCost, dateList) * BudgetStrategy.#AVERAGE_DAYS_IN_A_MONTH_DECIMAL;
    }

    /**
     * Returns the calculated cost of a single record over the course of a day's time.
     * @param {decimal} totalCost The accumulated costs of all of the records for variable income/expense.
     * @param {Date[]} dateList The compiled list of each record's timestamp when it occurred. 
     * @returns {decimal} The calculated cost of a single record over the course of a day's time.
     */
    GetDailyCost(totalCost, dateList) {
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

        // TODO - this could be divided by zero by accident.  Instead assume this is the cost for the month.
        let dailyCost = totalCost / diffDays;
        return dailyCost;
    }


}