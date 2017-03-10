package application.view;

import java.sql.SQLException;

import application.MainApp;
import application.model.Database;
import javafx.fxml.FXML;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

public class RootController {
	
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
		// TODO: make this pass an actual query to the database
		System.out.println(query);
		
		// TODO: make this show the result from the query
		output.setText("Handeling your query, please wait...");
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
	
	public void setMainApp(MainApp mApp) {
		this.mainApp = mApp;
	}
}
