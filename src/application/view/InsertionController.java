package application.view;

import java.sql.SQLException;
import java.sql.Statement;

import application.MainApp;
import application.model.AppController;
import application.model.Database;
import javafx.fxml.FXML;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.TextField;

public class InsertionController implements AppController {

	private MainApp mainapp;
	@FXML
	private TextField navn;
	@FXML
	private TextField beskrivelse;

	@Override
	public void setMainApp(MainApp mainApp) {
		this.mainapp = mainApp;

	}
	@FXML
	private void handleInsert(){
		//INSERT INTO aktivitet (Navn, Beskrivelse) VALUES ('Crossfit', 'muskeltrening for å bli ripped');
		Database db = mainapp.getDatabase();
		Statement sm = db.getStatement();
		try {
			String sql = "INSERT INTO aktivitet (Navn, Beskrivelse) " + "VALUES (" + "'" + navn.getText() + "'" + ", '" + beskrivelse.getText() + "')";
			sm.executeUpdate(sql);
		} catch (SQLException e) {
			mainapp.postAlert(AlertType.ERROR, "Insert failed", "Kunne ikke legge til aktivitet");
			e.printStackTrace();
		}
		navn.setText("");
		beskrivelse.setText("");
		mainapp.postAlert(AlertType.INFORMATION, "Suksess!", "Lagt til ny aktivitet i databasen!");
		
	}
	
	
	@FXML
	private void handleTilbake(){
		mainapp.changeView("view/App.fxml");
	}
	

}
