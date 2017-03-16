package application.view;

import java.sql.SQLException;

import application.MainApp;
import application.model.AppController;
import application.model.Database;
import javafx.fxml.FXML;
import javafx.scene.control.Alert.AlertType;

public class ApplicationController implements AppController {

	private Database database;
	private MainApp mainApp;
	
	@Override
	public void setMainApp(MainApp mainApp) {
		// TODO Auto-generated method stub
		this.mainApp = mainApp;
		database = mainApp.getDatabase();
	}
	
	@FXML
	private void handleDisconnect() {
		try {
			this.database.getStatement().close();
			this.database.disconnect();
			mainApp.changeView("view/LoginPane.fxml");
		} catch (SQLException e) {
			this.mainApp.postAlert(AlertType.ERROR, "Error when attempting to disconnect", "Something went wrong when disconnecting from the database");
			e.printStackTrace();
		}
	}
	@FXML
	private void handleInsertion(){
			mainApp.changeView("view/Insertion.fxml");
	}
	@FXML
	private void handleSelect(){
		mainApp.changeView("view/Select.fxml");
	}

}
