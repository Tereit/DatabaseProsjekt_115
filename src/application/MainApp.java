package application;

import application.view.RootController;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

public class MainApp extends Application {

	static RootController rootController;
	
	@Override
	public void start(Stage stage) throws Exception {
	    
		FXMLLoader loader = new FXMLLoader();
		loader.setLocation(MainApp.class.getResource("../application.view/Root.fxml"));
		AnchorPane root = (AnchorPane) loader.load();

		Scene scene = new Scene(root);
		stage.setScene(scene);
		stage.show();
		
	}
	
	public static void main(String[] args) {
		launch(MainApp.class, args);
	}
}
