using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExpensesLibrary.Repository
{
    public class ExpensesRepository
    {
        // TODO - Since we do not require relational data, a NoSql database will be a better implementation.
        readonly MySqlConnection _connection;

        public ExpensesRepository(MySqlConnection databaseConnection) 
        {
            _connection = databaseConnection;
        }

        public ExpensesAudit GetExpensesAudit(int id)
        {
            ExpensesAudit expensesAudit = new ExpensesAudit();
            const string sqlCommandText = "SELECT expenses_json FROM expenses WHERE id = @id;";
            MySqlCommand sqlStatement = new MySqlCommand(sqlCommandText, _connection);
            sqlStatement.Parameters.AddWithValue("@id", id);
            try
            {
                _connection.Open();
                using (MySqlDataReader rs = sqlStatement.ExecuteReader())
                {
                    if (rs.Read())
                    {
                        expensesAudit = JsonConvert.DeserializeObject<ExpensesAudit>(rs[0].ToString());
                    }
                }
                _connection.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            return expensesAudit;
        }
        public void SetExpensesAudit(int id, ExpensesAudit expensesAudit)
        {
            string json = JsonConvert.SerializeObject(expensesAudit);
            const string sqlCommandText = "INSERT INTO expenses VALUES (@json) ON CONFLICT UPDATE expenses SET expenses_json = @json WHERE id = @id;";
            MySqlCommand sqlStatement = new MySqlCommand(sqlCommandText, _connection);
            sqlStatement.Parameters.AddWithValue("@id", id);
            sqlStatement.Parameters.AddWithValue("@json", json);
            try
            {
                _connection.Open();
                sqlStatement.ExecuteNonQuery();
                _connection.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }
    }
}
