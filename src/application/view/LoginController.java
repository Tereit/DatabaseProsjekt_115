package application.view;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;


import application.MainApp;
import application.model.AppController;
import application.model.Database;
import javafx.fxml.FXML;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

public class LoginController implements AppController {
	
	private Database database;
	private MainApp mainApp;	
	
	@FXML
	private TextField search;
	@FXML
	private Label output;
	@FXML
	private TextField username;
	@FXML
	private PasswordField password;

	
	@FXML
	private void initialize() {
		
	}
	
	@FXML
	private void handleConnect() {
		database = new Database(MainApp.URL, username.getText(), password.getText());
		
		if(!database.connect()) {
			this.mainApp.postAlert(AlertType.ERROR, "Can't connect", "Could not connect to the database.\nPlease make sure the server is running, and that the login info is correct");
			return;
		}
		output.setText("Connection established...");
	}
	
	@FXML
	private void handleQuery() {
	
			String query = search.getText();
			if (query.startsWith("insert")){
				handleInsert(query);
			} if (query.startsWith("select")){
				handleSelect(query);
			}
		
	}
	
	private void handleInsert(String quary){
		Statement stmt = database.getStatement();
		try {
			stmt.executeUpdate(quary);
		} catch (SQLException e) {
			this.mainApp.postAlert(AlertType.ERROR, "Statement failed","Statement failed");			e.printStackTrace();
			e.printStackTrace();
		}
		System.out.println(quary);
		output.setText("Handeling your query, please wait...");

		
	}
	private void handleSelect(String quary){
		Statement stmt = database.getStatement();
		try {
			ResultSet rs = stmt.executeQuery(quary);
			ResultSetMetaData rsmd = rs.getMetaData();
			int antallKol = rsmd.getColumnCount();
			System.out.println(antallKol);
			while (rs.next()){
				String henteUt = "";
				for (int i = 1; i < antallKol+1; i++){
					System.out.println(rs.getString(i));
					henteUt += rs.getString(i) + " ";
				}

				System.out.println(henteUt);
				output.setText(henteUt);
			}
		} catch (SQLException e) {
			this.mainApp.postAlert(AlertType.ERROR, "Statement failed","Statement failed");			e.printStackTrace();
			e.printStackTrace();
		}
		//System.out.println(quary);
		//String henterut = "";
		//output.setText(henterut);

		
	}
	
	@FXML
	private void handleDisconnect() {
		try {
			this.database.disconnect();
		} catch (SQLException e) {
			this.mainApp.postAlert(AlertType.ERROR, "Error when attempting to disconnect", "Something went wrong when disconnecting from the database");
			e.printStackTrace();
		}
	}

	@Override
	public void setMainApp(MainApp mainApp) {
		this.mainApp = mainApp;
	}
	

}
