
/* 

export PATH=$PATH:$ORACLE_HOME/jdk/bin
export CLASSPATH=./:$ORACLE_HOME/jdbc/lib/ojdbc6.jar
javac OracleCon.java
java OracleCon

*/

import oracle.jdbc.*;
import java.sql.*;
import oracle.jdbc.pool.OracleDataSource;
 
class OracleSleep{
	public static void main(String args[]){
		try{

			// the 3 '/' are important to make it a URL
			// System.setProperty("java.security.egd", "file:///dev/urandom");  

			Class.forName("oracle.jdbc.driver.OracleDriver");

			OracleDataSource ods = new OracleDataSource();
			ods.setURL("jdbc:oracle:thin:scott/tiger@oravm01:1521:oravm1");
			Connection con = ods.getConnection();

			String plsql = "begin dbms_lock.sleep(60); end;";

			CallableStatement cs = con.prepareCall(plsql);
			cs.execute();

			cs.close();
			con.close();

		}

		catch(Exception e){ System.out.println(e);}

	}
}

