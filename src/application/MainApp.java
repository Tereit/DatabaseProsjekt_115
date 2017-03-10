package application;

import application.view.RootController;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

public class MainApp extends Application {

	public static final String URL = "jdbc:mysql://localhost/treningsdagbok";

	//static final String USER = "user";
	//static final String PASS = "password";
	
	@Override
	public void start(Stage stage) {
		try {
			
			FXMLLoader loader = new FXMLLoader(getClass().getResource("view/RootPane.fxml"));
			AnchorPane root = loader.load();
			
			RootController controller = loader.getController();
			controller.setMainApp(this);
			
			Scene scene = new Scene(root);
			stage.setScene(scene);
			stage.show();	
			stage.setResizable(false);
		}

		catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	public void postAlert(AlertType type, String title, String content) {
		Alert alert = new Alert(type);
		alert.setTitle(title);
		alert.setContentText(content);
		
		alert.showAndWait();
	}
	
	
	
	public static void main(String[] args) {
		launch(MainApp.class, args);
	}
}
