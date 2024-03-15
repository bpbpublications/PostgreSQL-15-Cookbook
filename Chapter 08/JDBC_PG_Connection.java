import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class JDBC_PG_Connection {
    public static void main(String[] args) {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/mydb", "myusr", "mypassword");
        } catch (SQLException e) {
            System.err.println(e);
            System.exit(1);
        }
        System.out.println("Connected to the PostgreSQL server successfully.");
        // use the connection to execute SQL queries
        // ...
        try {
            conn.close();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }
}