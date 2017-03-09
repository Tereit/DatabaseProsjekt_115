package application.view;

import application.model.Database;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

public class RootController {
	
	private Database database = new Database();
	
	@FXML
	private TextField search;
	@FXML
	private Label output;
	
	
	@FXML
	private void initialize() {
		
		
		
	}
}
