package application.view;

import java.sql.ResultSet;
import java.sql.SQLException;

import application.MainApp;
import application.model.AppController;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.control.TableView;
import javafx.util.Callback;

public class SelectController implements AppController {
	private MainApp mainapp;
	@FXML
	private ChoiceBox<String> box;

	@FXML
	private TableView tw;

	@FXML
	private ObservableList<ObservableList> data;

	@Override
	public void setMainApp(MainApp mainApp) {
		this.mainapp = mainApp;
	}

	@FXML
	private void initialize() {
		box.getItems().addAll("Aktiviteter", "Øvelser", "Treningsøkt");
	}

	@FXML
	private void handleChoice() {
		tw.getItems().clear();
		tw.getColumns().clear();
		data = FXCollections.observableArrayList();

		ResultSet rs;
		String SQL;
		if (box.getValue() == "Aktiviteter") {
			SQL = "SELECT * from aktivitet";
		} else if (box.getValue() == "Øvelser") {
			SQL = "SELECT * FROM øvelse";
		} else {
			SQL = "SELECT * FROM treningsøkt";
		}
		try {
			rs = mainapp.getDatabase().getStatement().executeQuery(SQL);
			for (int i = 0; i < rs.getMetaData().getColumnCount(); i++) {
				final int j = i;
				TableColumn col = new TableColumn(rs.getMetaData().getColumnName(i + 1));
				col.setCellValueFactory(
					new Callback<CellDataFeatures<ObservableList, String>, ObservableValue<String>>() {
						public ObservableValue<String> call(CellDataFeatures<ObservableList, String> param) {
							return new SimpleStringProperty(param.getValue().get(j).toString());
						}
					});
				tw.getColumns().addAll(col);
			}
			while (rs.next()) {
				// Iterate Row
				ObservableList<String> row = FXCollections.observableArrayList();
				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					// Iterate Column
					row.add(rs.getString(i));
				}
				data.add(row);
			}
			tw.setItems(data);
		} catch (SQLException e) {
			mainapp.postAlert(AlertType.ERROR, "Failed to select from aktiviteter", "Kan ikke hente aktiviteter");
			e.printStackTrace();
		}
	}

	@FXML
	private void handleTilbake() {
		mainapp.changeView("view/App.fxml");
	}
}
