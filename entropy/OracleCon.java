
/* 

export PATH=$PATH:$ORACLE_HOME/jdk/bin
export CLASSPATH=./:$ORACLE_HOME/jdbc/lib/ojdbc6.jar
javac OracleCon.java
java OracleCon

*/

import oracle.jdbc.*;
import java.sql.*;
import oracle.jdbc.pool.OracleDataSource;
 
class OracleCon{
	public static void main(String args[]){
		try{

			// the 3 '/' are important to make it a URL
			// System.setProperty("java.security.egd", "file:///dev/urandom");  

			Class.forName("oracle.jdbc.driver.OracleDriver");

			OracleDataSource ods = new OracleDataSource();
			ods.setURL("jdbc:oracle:thin:scott/tiger@oravm01:1521:oravm1");
			Connection con = ods.getConnection();

			/* 
			Statement stmt=con.createStatement();
			
			ResultSet rs=stmt.executeQuery("select * from emp");
			while(rs.next())
			System.out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3));
			*/

			con.close();

		}

		catch(Exception e){ System.out.println(e);}

	}
}

