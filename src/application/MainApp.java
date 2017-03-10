package application;

import java.io.IOException;

import application.view.LoginController;
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
	private AnchorPane root;
	
	private void changeView(String path) {
		
		try {
			FXMLLoader loader = new FXMLLoader(getClass().getResource(path));
			AnchorPane pane = (AnchorPane) loader.load();
			
			root.getChildren().add(pane);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void start(Stage stage) {
		try {
			
			FXMLLoader loader = new FXMLLoader(getClass().getResource("view/Root.fxml"));
			root = (AnchorPane) loader.load();
			
			//RootController controller = loader.getController();
			//controller.setMainApp(this);
			
			Scene scene = new Scene(root);
			stage.setScene(scene);
			stage.show();	
			stage.setResizable(false);
		}

		catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public static void main(String[] args) {
		launch(MainApp.class, args);
	}
	
	public void postAlert(AlertType type, String title, String content) {
		Alert alert = new Alert(type);
		alert.setTitle(title);
		alert.setContentText(content);
		
		alert.showAndWait();
	}
}
