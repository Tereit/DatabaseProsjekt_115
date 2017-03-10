package application;

import java.io.IOException;

import application.model.AppController;
import application.model.Database;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

public class MainApp extends Application {
	
	private Database database;

	public static final String URL = "jdbc:mysql://localhost/treningsdagbok";

	//static final String USER = "user";
	//static final String PASS = "password";
	private AnchorPane root;
	private AppController controller;
	
	public void changeView(String path) {
		
		try {
			FXMLLoader loader = new FXMLLoader(getClass().getResource(path));
			AnchorPane pane = (AnchorPane) loader.load();
			
			controller = loader.getController();
			controller.setMainApp(this);
			
			root.getChildren().clear();
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

			
			Scene scene = new Scene(root);
			stage.setScene(scene);
			stage.show();	
			stage.setResizable(false);
			
			changeView("view/LoginPane.fxml");
		}

		catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void setDatabase(Database database) {
		this.database = database;
	}
	
	public Database getDatabase() {
		return database;
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
