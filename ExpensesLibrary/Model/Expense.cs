using System;

namespace ExpensesLibrary
{
    [Serializable]  
    public class Expense
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal Cost { get; set; }
        public Frequency Frequency { get; set; }
    }
}